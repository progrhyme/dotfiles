# dotfiles

To set up *dotfiles* into your home directory, execute following commands:

```sh
git clone git@github.com:progrhyme/dotfiles.git 
cd dotfiles
git submodule update --init
script/setup-dotfiles.sh
script/setup-vim-env.sh
```

You can set up customized shell environments locating additional shell scripts
in `envs/$DOTS_ENV`.

```sh
ln -s path/to/my-scripts envs/my-env
export DOTS_ENV=my-env
script/setup-shellenv.sh
```

Related Projects:

- [progrhyme/myenv](https://github.com/progrhyme/myenv)
... contains various CLI materials for Ubuntu, macOS etc., utilizing _dotfiles_.

# Setup Scripts
## script/setup-dotfiles.sh

Most implementation is in `lib/dotfiles.bashrc`.
In addition to making symbolic links to dotfiles under the root directory, this
script does by default create symbolic links to scripts in `*shrc.d/` directory
into `~/.{ba,z}shrc.d/` directory according to `$SETUP_SHELL` variable; falling
back to `$SHELL` if `$SETUP_SHELL` is undefined.
Destination directory is defined by variable `$CUSTOM_RC_DIR` in `lib/setup.bashrc`.

# Shell Configuration
## peco functions

`{ba,z}shrc.d/peco.{ba,z}shrc` defines some functions invoked by keyboard
shortcuts using key binding system.

 Key | Bash | Zsh | Functionality
-----|------|-----|---------------
 `Ctrl-U + P` | ✅ | | Search and insert Process ID onto prompt
 `Ctrl-R` | ✅ | ✅ | Search and select command from history
 `Ctrl-U + D` | ✅ | ✅ | Search directories from repositories under predefined directories and Change Directory to selected one
 `Ctrl-U + F` | ✅ | ✅ | Search any files from repositories under predefined directories and insert selected one onto prompt
 `Ctrl-U + C` | ✅ | ✅ | Search any files under current directory and insert selected one onto prompt
 `Ctrl-U + A` | ✅ | ✅ | Search any files including hidden entries under current directory and insert selected one onto prompt
 `Ctrl-U + R` | | ✅ | Search directories from Zsh cdr history and Change Directory to selected one
 `Ctrl-U + X` | ✅ | ✅ | Search kubectl contexts and activate selected one
 `Ctrl-U + N` | ✅ | ✅ | Search kubectl namespaces and set selected one to default
 `Ctrl-U + G` | ✅ | ✅ | Search gcloud config configurations and activate selected one
