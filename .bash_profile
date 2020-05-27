export DOTS_ROOT="${HOME}/.dotfiles"

if [[ -r $HOME/.bash_profile.extra ]]; then
  source $HOME/.bash_profile.extra
fi

if [[ -r $HOME/.bashrc ]]; then
  source $HOME/.bashrc
fi

# history
HISTSIZE=10000
SAVEHIST=10000
HISTTIMEFORMAT='%F %T  '
