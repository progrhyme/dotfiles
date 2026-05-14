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
