# load common shrc
source $DOTS_ROOT/shrc.d/load_apps.shrc
_SHELP_INCLUDES=(gcloud-prompt:gcloud-prompt.sh)
source $DOTS_ROOT/shrc.d/load_shelp.shrc
source $DOTS_ROOT/shrc.d/aliases

# disable by default
echo "Execute \e[1mtoggle_gcloud_prompt\e[0m to show/hide gcloud info on prompt"
GCLOUD_PROMPT_ENABLED=
GCLOUD_PROMPT_CONFIG_KEYS=(core.project compute.region)

# Colors
autoload -U colors
colors

# auto completion
autoload -U compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ignore case matching
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt auto_list  # list complementary items
setopt correct    # correct misspell
setopt auto_menu
setopt extended_glob

# cd & pushd
setopt auto_cd    # cd to directory with directory path only
#setopt auto_pushd # pushd when cd
setopt pushd_ignore_dups

# cdr
mkdir -p $HOME/.cache/shell
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# history
setopt extended_history # record executed time to history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks

## custom PATH
PATH=".:$HOME/bin:$PATH"

# PROMPT settings (1)
setopt prompt_subst
RPROMPT="%F{247}%*%f"

############################################################
# oh-my-zsh
plugins=(
  shrink-path
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
## unset vars set by oh-my-zsh
unset PAGER LESS

# oh-my-zsh theme/plugin configs
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=green,bold"

#===========================================================
# PROMPT settings (2)

tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

PROMPT2=$tmp_prompt2
SPROMPT=$tmp_sprompt

[[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"

unset tmp_prompt2 tmp_sprompt

# kubectl ctx/ns
__zsh_kubectl_prompt="/usr/local/etc/zsh-kubectl-prompt/kubectl.zsh"
if [[ -r $__zsh_kubectl_prompt && -z "${ZSH_KUBECTL_PROMPT:-}" ]]; then
  source $__zsh_kubectl_prompt

  if [[ ! -v __KUBECTL_PROMPT__ ]]; then
    echo "Execute \e[1mtoggle_kubectl_prompt\e[0m to show/hide Kubernetes" \
      "context/namespace on prompt"
    __KUBECTL_PROMPT__=
  fi

  toggle_kubectl_prompt() {
    if [[ -n "${__KUBECTL_PROMPT__:-}" ]]; then
      __KUBECTL_PROMPT__=
    else
      __KUBECTL_PROMPT__=1
    fi
  }
fi
unset __zsh_kubectl_prompt

# /PROMPT settings (2)
#===========================================================

# remove duplicate PATH
typeset -U path PATH

############################################################
# extentional settings

# direnv
eval "$(direnv hook zsh)"

#===========================================================
# PROMPT settings (3)

source $DOTS_ROOT/zshrc.d/darwin/iterm2_shell_integration.zsh

## overwrite build_prompt() from agnoster.zsh-theme
if [[ "${ITERM_SHELL_INTEGRATION_INSTALLED:-}" = "Yes" ]]; then
  build_prompt() {
    RETVAL=$?
    prompt_segment blue $CURRENT_FG $(shrink_path -f)
    prompt_git
    prompt_end
  }
else
  build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_segment blue $CURRENT_FG $(shrink_path -f)
    prompt_git
    prompt_end
  }
fi
PROMPT='%{%f%b%k%}$(build_prompt) '

precmd () {
  local prompt_info=
  local _either _bg=$CURRENT_BG

  if [[ -n "${GCLOUD_PROMPT_ENABLED:-}" ]]; then
    _either=on
    CURRENT_BG=yellow
    local _gcloud_icon="☁️"
    prompt_info="$(prompt_segment $CURRENT_BG black "${_gcloud_icon}  $(gcloud_prompt)")"
  fi

  if [[ -n "${__KUBECTL_PROMPT__:-}" ]]; then
    _either=on
    local _kp="⎈ ${ZSH_KUBECTL_PROMPT}"
    if [[ -n "${GCLOUD_PROMPT_ENABLED:-}" ]]; then
      prompt_info="${prompt_info}$(prompt_segment blue white ${_kp})"
      CURRENT_BG=blue
    else
      CURRENT_BG=blue
      prompt_info="$(prompt_segment $CURRENT_BG white ${_kp})"
    fi
  fi

  if [[ -n "${_either}" ]]; then
    prompt_info="${prompt_info}$(prompt_end)"
    CURRENT_BG=$_bg
  fi

  if ((${#prompt_info} > 0)); then
    print
    print -P $prompt_info
  fi
}
# /PROMPT settings (3)
#===========================================================

# zsh-syntax-highlighting
_highlighter="/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -r "${_highlighter}" ]]; then
  source $_highlighter
fi
unset _highlighter

############################################################
# scripts to exec on login
update-local-repos

if [[ -d $HOME/.init.d ]]; then
  for _script in `find $HOME/.init.d -mindepth 1`; do
    if [[ -x $_script ]]; then
      echo "\e[32mRun -- ${_script}\e[0m"
      $_script
    else
      echo "\e[31mERROR! ${_script} is not executable!\e[0m"
    fi
  done
fi
