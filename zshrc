PATH="$DOTS_ROOT/bin:$PATH"

# Load zshrc files
if [[ -d $HOME/.zshrc.d ]]; then
  for file in `find $HOME/.zshrc.d -mindepth 1 -maxdepth 1 | sort`; do
    if [[ ${file:t} == "peco.zshrc" && -t 0 && -t 1 ]]; then
      continue
    fi
    [[ -f $file ]] && source $file
  done

  if [[ -t 0 && -t 1 && -d $HOME/.zshrc.d/interactive ]]; then
    for file in `find $HOME/.zshrc.d/interactive -mindepth 1 -maxdepth 1 | sort`; do
      [[ -f $file ]] && source $file
    done
  fi

  # Lazy load peco.zshrc for interactive shells
  if [[ -t 0 && -t 1 && -f $HOME/.zshrc.d/peco.zshrc ]]; then
    source $HOME/.zshrc.d/peco.zshrc
  fi
fi
