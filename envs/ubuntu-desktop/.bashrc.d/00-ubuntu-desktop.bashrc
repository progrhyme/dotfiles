# load common shrc
source $DOTS_ROOT/shrc.d/load_apps.shrc

## custom PATH
PATH=".:$HOME/bin:$PATH"

_SHELP_INCLUDES=(sh-pathctl:pathctl.shrc)
source $DOTS_ROOT/shrc.d/load_shelp.shrc
source $DOTS_ROOT/shrc.d/aliases
source $DOTS_ROOT/bashrc.d/load_enhancd.bashrc

# remove duplicate PATH
pathctl_uniq

############################################################
# scripts to exec on login
update-local-repos
