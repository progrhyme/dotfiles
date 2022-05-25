PATH="$DOTS_ROOT/bin:$PATH"

if [[ -t 0 && -t 1 ]]; then
  # Load bashrc files
  if [[ -d $HOME/.bashrc.d ]]; then
    for file in `find $HOME/.bashrc.d -mindepth 1 | sort`; do
      source $file
    done
  fi
fi
