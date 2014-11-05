##############
# .zshrc Mac Version
# Author:  Isao Nakamura (github.com/n10o)
# Created: 2008/05/18
##############
# Keybind Example
# M-q(command stack), M-h(man), C-w, cd -TAB  
# rm *~(TAB or C-x g) ワイルドカードがどのように展開されるか確認
# C-/でなぜかUndoできない．C-x u なら可
##############
#export LANG=ja_JP.UTF-8
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)" # this is too heavy

export PATH=/opt/local/bin:/opt/local/sbin/:~/sh:$PATH
export MANPATH=/opt/local/man:$MANPATH
export PATH=$PATH:/usr/local/mysql/bin

autoload -U compinit; compinit                 # 補完の有効
zstyle ':completion:*' list-colors di=34 fi=0  # 色つきの補完
zstyle ':completion:*:default' menu select=1   # 補完候補をカーソルで選択

bindkey -e   # Emacs like keybind こっちのほうが一般的なターミナル操作に近い
#bindkey -v  # vi like keybind

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # /を区切り文字から除外，パス名を入力中にC-wで1ディレクトリだけ削除
#LISTMAX=0    # 補完候補を尋ねる数

##############
## Alias
##############
alias ls="ls -vFG"
alias ll="ls -vFla"
alias la="ls -vFa"
alias pd=popd
alias -g G="| grep "
alias -g L="| less -r"
alias ql="qlmanage -p "$@" >& /dev/null"  # MacのQuickLook
alias if-restart="sudo ifconfig en1 down;sudo ifconfig en1 up"
# alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
# alias fcd="source ~/sh/fcd.sh"  # MacのFinderの場所にcd
# alias sshfs-xxxxx="/Applications/sshfs.app/Contents/Resources/sshfs-static username@ipaddress:/ ~/mnt -p 7022 -oping_diskarb,volname=xxxxx"
function history-all { history -E 1 }  # 全履歴の一覧を出力

##############
## History
##############
HISTFILE=$HOME/.zhistory     # 履歴を指定のファイルに保存
HISTSIZE=100000              # メモリ内の履歴の最大サイズ
SAVEHIST=10000000            # 保存される最高履歴数
setopt extended_history      # 履歴ファイルに開始時刻と経過時間を記録
setopt append_history        # 履歴を追加
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt share_history         # 履歴の共有
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space     # スペースで始まるコマンド行はヒストリリストから削除
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
setopt hist_save_no_dups     # ヒストリファイルに書き出すときに、古いコマンドと同じものは無視
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_expand           # 補完時にヒストリを自動的に展開
unsetopt hist_verify         # ヒストリを呼び出してから実行する間に一旦編集不可に

##############
## Misc
##############
setopt auto_cd               # $0がディレクトリの場合自動的にcd
setopt autopushd             # 自動でpushd．Try popd and cd -[Tab]
setopt COMPLETE_IN_WORD      # 単語の途中で補完
setopt auto_menu             # Tab, C-i で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加
setopt noautoremoveslash     # パスの最後につくスラッシュの自動削除を解除
setopt brace_ccl             # {a-c} を a b c に展開する機能
setopt equals                # =command を command のパス名に展開
setopt list_types            # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完可
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加
setopt print_eightbit        # 日本語のファイル名などを見れるようになる．化けたらこれ
setopt NO_beep               # BEEP音を止める
#setopt auto_remove_slash    # 最後がディレクトリ名で終わっている場合末尾の / を自動的に削除
#setopt correct              # コマンドミス修正機能
#setopt list_packed          # コンパクトな補完リスト

##############
## Prompt
##############
unsetopt promptcr            # 改行で終わらない出力も可能に
setopt PROMPT_SUBST          # エスケープシーケンスを使用

local GREEN=$'%{[32m%}'
local BLUE=$'%{[34m%}'
local DEFAULT=$'%{[m%}'

PROMPT=$BLUE'$USER/%m%(!.#.$) '$DEFAULT
RPROMPT=$GREEN'[%~]'$DEFAULT

##############
# Reference:
# 1. man zshoptions
# http://www.ayu.ics.keio.ac.jp/~mukai/translate/zshoptions.html
# 2. UNIX今日の技/zsh
# http://www.q-eng.imat.eng.osaka-cu.ac.jp/~ippei/unix/zsh.html
# 3. 漢のzsh
# http://journal.mycom.co.jp/column/zsh/
##############
