# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"
# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

# ロケールを日本
export LANG=ja_JP.UTF-8

# init java
. $HOME/.asdf/plugins/java/set-java-home.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
