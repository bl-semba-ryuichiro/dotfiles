# vivaldi
alias vivaldi='open -n /Applications/Vivaldi.app &'
alias viv=vivaldi

# exa
if [[ $(command -v exa) ]]; then
  alias e='exa --icons'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons'
  alias la=ea
  alias ee='exa -aal --icons'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
fi

# docker
if [ -e ~/.zsh/completions ]; then
    fpath=(~/.zsh/completions $fpath)
fi

# sheldon
eval "$(sheldon source)"

# zoxide
eval "$(zoxide init zsh)"

# starship
eval "$(starship init zsh)"

#----------------------------------------------------------------

# 履歴ファイルの保存先
HISTFILE=$HOME/.zsh_history
# メモリに保存される履歴の件数
HISTSIZE=1000000
# HISTFILE で指定したファイルに保存される履歴の件数
SAVEHIST=1000000
# 履歴を他のシェルとリアルタイム共有する
setopt share_history
# 同じコマンドをhistoryに残さない
setopt hist_ignore_all_dups
# historyに保存するときに余分なスペースを削除する
setopt hist_ignore_space
# historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 重複するコマンドが保存されるとき、古い方を削除する
setopt hist_save_no_dups
# 実行時に履歴をファイルに追加していく
setopt inc_append_history

# 不要なコマンドを history
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|history|jj?|lazygit|la|ll|ls|rm|rmdir|trash)($| )" ]]
}

#----------------------------------------------------------------

# fzf の設定
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fd と組み合わせてファイル検索を高速化
if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf 2> /dev/null'
  export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'
  _fzf_compgen_path() {
    command fd -c always -H --no-ignore-vcs -E .git -tf . "${1}"
  }
  _fzf_compgen_dir() {
    command fd -c always -H --no-ignore-vcs -E .git -td . "${1}"
  }
  export FZF_DEFAULT_OPTS="--ansi ${FZF_DEFAULT_OPTS}"
  # rg と組み合わせて文字列検索を高速化
elif (( ${+commands[rg]} )); then
  export FZF_DEFAULT_COMMAND="command rg -uu -g '!.git' -g '!node_modules' --files 2> /dev/null"
  _fzf_compgen_path() {
    command rg -uu -g '!.git' --files "${1}"
  }
fi
# bat と組み合わせてプレビュー内容にシンタックスハイライトを適用
if (( ${+commands[bat]} )); then
  export FZF_CTRL_T_OPTS="--preview 'command bat --color=always --line-range :500 {}' ${FZF_CTRL_T_OPTS}"
fi

if (( ${+FZF_DEFAULT_COMMAND} )) export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

zle -N fzf-z-search
bindkey '^f' fzf-z-search

# ghq と組み合わせて リポジトリをインクリメンタルに検索しつつ移動 (プレビューはREADME)
function ghq-fzf() {
  local src=$(ghq list |fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

#----------------------------------------------------------------