# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.pre.bash"
# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

# ロケールを日本
export LANG=ja_JP.UTF-8

# init java
. $HOME/.asdf/plugins/java/set-java-home.bash

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.post.bash"
