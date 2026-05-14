# load common shrc
source $DOTS_ROOT/shrc.d/load_apps.shrc
if [[ -t 0 && -t 1 ]]; then
  _SHELP_INCLUDES=(gcloud-prompt:gcloud-prompt.sh)
fi
source $DOTS_ROOT/shrc.d/load_shelp.shrc
source $DOTS_ROOT/shrc.d/aliases

## custom PATH
PATH=".:$HOME/bin:$PATH"

# remove duplicate PATH
typeset -U path PATH

# direnv
eval "$(direnv hook zsh)"
