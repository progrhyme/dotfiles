PATH="$DOTFILES/bin:$PATH"

# Load bashrc files
if [[ -d $HOME/.bashrc.d ]]; then
  for file in `find $HOME/.bashrc.d -mindepth 1 | sort`; do
    source $file
  done
fi
