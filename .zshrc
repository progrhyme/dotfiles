PATH="$DOTS_ROOT/bin:$PATH"

# Load zshrc files
if [[ -d $HOME/.zshrc.d ]]; then
  for file in `find $HOME/.zshrc.d -mindepth 1 | sort`; do
    source $file
  done
fi
