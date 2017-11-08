# dotfiles

To set up *dotfiles* into your home directory, execute following commands:

```sh
git clone git@github.com:progrhyme/dotfiles.git 
cd dotfiles
git submodule update --init
script/setup-all-links.sh
script/set-custom-shrc-links.sh
script/setup-vim-env.sh
```

