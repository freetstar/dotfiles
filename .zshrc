# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="xiong-chiamiov"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Created by freetstar at 20101226

#########################First Section########################
# History Setting{{{
export HISTFILE=~/.histfile
export HISTSIZE=5000
export SAVEHIST=5000

#
setopt INC_APPEND_HISTORY
#忽略重复的历史命令
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt bang_hist

#启用cd命令的历史记录,cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格,不将此命令添加到记录文件中
setopt HIST_IGNORE_SPACE
#}}}
##############################################################


###################Second Section#############################
#others{{{
#允许在交互模式中试用注释
#cmd #这是注释
setopt INTERACTIVE_COMMENTS

#启动自动cd ,输入目录名则进入目录
setopt AUTO_CD

#如果cd后跟的不是一个目录，然后会用~来替代====failure
#setopt CDABLE_VARS

#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt  complete_in_word

#禁用core dumps
limit coredumpsize 0 

#自动补全功能
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项,补全时会直接选中菜单项
setopt MENU_COMPLETE
    #如果你开启了一个进程，之后你忘记了开启另外一个进程，那么本选项会默认使用之前开启的进程
setopt AUTO_RESUME

#}}}
##############################################################


################Promote setting###############################
#Prompt setup
autoload -U promptinit
promptinit

#开启prompts的大多数扩展===failure
#prompt_subst

prompt  bart
##############################################################

zmodload zsh/complist
autoload -Uz compinit
compinit
################auto completion###############################
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion:*:cd:*' ignore-parents parent pwd 

zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect: lines: %L matches: %M [%p]'

zstyle ':completion:*:match:*' original only  
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete_correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
#如果是用路径作为参数，则把\给去掉,ln时比较有用
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::completion:*' '\\'

#彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)* =0=01;31'

#补全ssh scp sftp等等
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
#修正大小写
zstyle ':completion:*' matcher-list '' 'm:(a-zA-Z)=(A-Za-z)'

#错误矫正
zstyle ':completion:*' completer _complete _math _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill命令补全
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' fore-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#命令补全
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options'  description 'yes'
zstyle ':completion:*:options'  auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m '
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warings' format $'\e[01;31m -- No Match Found -- \e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d(errors: %e) -- \e[0m'

#忽略补全函数补全没有的命令
zstyle ':completion:*:functions' ignored-patterns '_*'

#cd  ~补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'name-directories' 'path-directories' 'users' 'expand'

#补全ping
zstyle  ':completion:*:ping:*' hosts 192.168.1.{1,4,11,101} www.baidu.com
#}}}

#重新rehash
_force_rehash() {
 (( CURRENT == 1 )) && rehash
 return 1	# Because we didn't really complete anything
}
zstyle ':completion:::::' completer _force_rehash _complete _approximate
##############################################################




################################add sudo#######################
sudo-command-line(){
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
#插入光表后,光表移动到行末尾
}
zle -N sudo-command-line
#Esc Esc 在命令前插入sudo
bindkey "\e\e" sudo-command-line
###############################################################


###################associate the file with applications#######
autoload -U zsh-mime-setup
zsh-mime-setup
alias -s png=eog
alias -s c=vim
alias -s cpp=vim
alias -s png=eog
alias -s html=$BROWSER
alias -s jpg=eog
alias -s gif=eog
alias -s doc=libreoffice
alias -s gz=tar -xzvf 
alias -s bz2=tar -xjvf
alias -s pdf=evince
alias -s glade=glade
alias -s rcg=soccerwindow2
alias -s zip=zipinfo
############################################################

####################alias configuration######################
#alias 别名设置
alias grep='grep --color=auto'
alias ll='ls -l'
alias hm="history|grep"
alias history='history -fi'
alias ls='ls --color=auto'
alias top10='print -l $((o)history%% *)|uniq -c|sort -nr|head -n 10'
alias killzom='ps -ef | grep defunct | grep -v grep | awk '{print "kill -9" $2,$3}''
alias killssh="kill $(ps aux|grep "ssh -q"|awk -F" " '{print $2}')"
alias p='pacman'
alias y='yaourt'
alias agi="apt-get install"
alias apa="apt-get autoremove"
alias apu="apt-get update"
alias apg="apt-get upgrade"
alias proxy="cd /home/freetstar/Downloads/proxy/goagent/local/;python2 proxy.py"
#全局alias
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g L="|less"
alias -g C="|wc -l"

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; } 

#hash
hash -d www="/var/www"
hash -d proxy="/home/freetstar/Downloads/proxy/goagent/"
#####zstyle
zstyle  :compinstall filename '/home/lgx/.zshrc'
#We set some options here
#setopt extended_glob
setopt correctall
export HISTTIMEFORMAT='%F %T '
#less 语法高亮需要安装source-highlight
PAGER='less -X -M'
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

export PATH=$PATH:/sbin:/usr/sbin
#让cat命令也语法高亮
hlcat(){ less $*|cat }
export http_proxy='http://localhost:8087'
#export https_proxy='https://localhost:8087'
alias tom='hlcat'
#########
#zsh有一个奇怪的现象,就是新安装完一个软件之后
#无法tab出来,也就是无法通过tab试用,只能全命令打出
#有答案说是zsh是先生成哈席表,故需要rehash一下...
#
#
#
#
#
#
#
#
#
#########3
TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

recolor-cmd() {
    region_highlight=()
    colorize=true
    start_pos=0
    for arg in ${(z)BUFFER}; do
        ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
        ((end_pos=$start_pos+${#arg}))
        if $colorize; then
            colorize=false
            res=$(LC_ALL=C builtin type $arg 2>/dev/null)
            case $res in
                *'reserved word'*)   style="fg=magenta,bold";;
                *'alias for'*)       style="fg=cyan,bold";;
                *'shell builtin'*)   style="fg=yellow,bold";;
                *'shell function'*)  style='fg=green,bold';;
                *"$arg is"*)         
                    [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
                *)                   style='none,bold';;
            esac
            region_highlight+=("$start_pos $end_pos $style")
        fi
        [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
        start_pos=$end_pos
    done
}

check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char

############################################################3
function smart_cd () {
  if [[ -f $1 ]] ; then
    [[ ! -e ${1:h} ]] && return 1
    print correcting ${1} to ${1:h}
    builtin cd ${1:h}
  else
    builtin cd ${1}
  fi
}

function cd () {
  setopt localoptions
  setopt extendedglob
  local approx1 ; approx1=()
  local approx2 ; approx2=()
  if (( ${#*} == 0 )) || [[ ${1} = [+-]* ]] ; then
    builtin cd "$@"
  elif (( ${#*} == 1 )) ; then
    approx1=( (#a1)${1}(N) )
    approx2=( (#a2)${1}(N) )
    if [[ -e ${1} ]] ; then
      smart_cd ${1}
    elif [[ ${#approx1} -eq 1 ]] ; then
      print correcting ${1} to ${approx1[1]}
      smart_cd ${approx1[1]}
    elif [[ ${#approx2} -eq 1 ]] ; then
      print correcting ${1} to ${approx2[1]}
      smart_cd ${approx2[1]}
    else
      print couldn\'t correct ${1}
    fi
  elif (( ${#*} == 2 )) ; then
    builtin cd $1 $2
  else
    print cd: too many arguments
  fi
}
###################################################
# Prefer ipython for interactive shell
smart_python () {
    # this function is actually rather dumb
    if [[ -n $1 ]]; then
        python $argv
    else
        #if no parameters were given, then assume we want an ipython shell
        if [[ -n $commands[ipython] ]]; then
            ipython
        else
            python
        fi
    fi
}

alias py=smart_python

# tab-complete options for smart_python just like for python
compdef _python smart_python
# Convert ogv to flv.
# Usage: ogv2flv input.ogv -o output.flv
# add -audiofile yoursound.wav if you need to replace the soundtrack 
alias ogv2flv='mencoder -of lavf -oac mp3lame -lameopts abr:br=56 -srate 22050 -ovc lavc -lavcopts vcodec=flv:vbitrate=250:mbd=2:mv0:trell:v4mv:cbp:last_pred=3 -vf scale=640:480'
#
# Customize to your needs...
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH
