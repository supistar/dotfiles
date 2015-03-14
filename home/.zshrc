### zsh core
# command correction
setopt correct
# No beep
setopt nolistbeep

# Key bind
bindkey "^[[3~" delete-char

# Command history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history
setopt hist_no_store
setopt hist_expand
setopt inc_append_history

# Search command history
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

### Aliases
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -AG'
alias l='ls -CFG'
alias rm='rmtrash'

# Settings of MacVim / "vi" and "vim" mapping to MacVim
export EDITOR=${HOME}/Applications/MacVim.app/Contents/MacOS/Vim
alias vi='env LANG=ja_JP.UTF-8 ${HOME}/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 ${HOME}/Applications/MacVim.app/Contents/MacOS/Vim "$@"'

# For vless
alias vless='/usr/share/vim/vim73/macros/less.sh'

# For mosh
alias mssh=mosh

# Disable auto correction
alias pod='nocorrect pod'
alias tree='nocorrect tree'
alias rspec='nocorrect rspec'
alias ino='nocorrect ino'
alias http='nocorrect http'

# less customize
export LESS='-R -X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
export PAGER=less

# ls colors
export LSCOLORS=gxfxcxdxbxegedabagacad

# Update right space prompt
# - Show current directory
# - Show github branch
autoload -Uz colors
colors
RESET="%{${reset_color}%}"
MAGENTA="%{${fg[magenta]}%}"
GREEN="%{${fg[green]}%}"

# For show files
chpwd() {
    #do_enter
    ls_abbrev
}

function ls_abbrev() {
    if [[ ! -r $PWD ]]; then
        return
    fi
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')
    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    local maxline=30
    if [ $ls_lines -gt $maxline ]; then
        echo "$ls_result" | head -n $(expr $maxline / 2)
        echo '...'
        echo "$ls_result" | tail -n $(expr $maxline / 2)
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

# For autojump
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# For z
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
       z --add "$(pwd -P)"
}

# Call precmd
function call_precmd() {
    local precmd_func
    (( $+functions[precmd] )) && precmd
    for precmd_func in $precmd_functions; do
        $precmd_func
    done
}

# Move to upper directory as ^
cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        call_precmd
        zle reset-prompt
    else
        zle self-insert '^'
        fi
}
zle -N cdup
bindkey '\^' cdup

# Show Git information and ll as [Enter]
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb 2> /dev/null
    fi
    call_precmd
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

# For Japanese
export LC_CTYPE="ja_JP.UTF-8"

# For Personal libraries
export PATH=/usr/local/bin:$PATH

# For Android Development
export ANDROID_HOME=/usr/local/opt/android-sdk

# For tmux scripts
export PATH=$HOME/.tmux/scripts:$PATH

# For Qt
export PATH=$PATH:/Applications/Qt5.1.1/5.1.1/clang_64/bin

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/usr/local/share/cocos2d-x-3.0/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT=/usr/local/opt/android-ndk
export PATH=$NDK_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT=/usr/local/bin
export PATH=$ANT_ROOT:$PATH

# For Java development
export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
export MAVEN_OPTS='-Xmx1024m -XX:MaxPermSize=256m'

# zsh completion
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# For auto completion
autoload -Uz compinit
compinit -u

# For powerline
export PATH=$HOME/.local/bin:$PATH
source $HOME/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Add anyenv to PATH for scripting
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
for D in `ls $HOME/.anyenv/envs`
do
  export PATH="$HOME/.anyenv/envs/$D/shims:$PATH" 
done
