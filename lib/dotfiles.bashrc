# bash

DOT_FILES=(
  .config/git/ignore
  .gemrc
  .gitconfig
  .perltidyrc
  .rubocop.yml
  .tmux.conf
  .vimrc
)

CUSTOM_RC_FILES=(
  "shrc.d/tmux.shrc"
)

case $SHELL in
  */bash)
    DOT_FILES+=(
      .bash_profile
      .bashrc
      .git-completion.bash
    )
    CUSTOM_RC_FILES+=(
      "bashrc.d/peco.bashrc"
      "bashrc.d/10-load-git-completion.bashrc"
    )
    ;;
  */zsh)
    DOT_FILES+=(.zshenv .zshrc)
    CUSTOM_RC_FILES+=("zshrc.d/peco.zshrc")
    ;;
  *) ;;
esac
