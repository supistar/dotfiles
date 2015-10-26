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

# For vless
alias vless='/usr/share/vim/vim73/macros/less.sh'

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

# For Personal libraries
export PATH=/usr/local/bin:$PATH

# For tmux scripts
export PATH=$HOME/.tmux/scripts:$PATH

# For powerline
export PATH=$HOME/.local/bin:$PATH
source $HOME/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Add anyenv to PATH for scripting
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - zsh)"
for D in `ls $HOME/.anyenv/envs`
do
  export PATH="$HOME/.anyenv/envs/$D/shims:$PATH" 
done

# For credentials
if [ -e $HOME/.credentials ]; then
    source $HOME/.credentials
fi

# For each environments
UNAME=$(uname | tr '[A-Z]' '[a-z]')
[ -f $HOME/.zsh/.zshrc_$UNAME ] && . $HOME/.zsh/.zshrc_$UNAME

# For select-word-style
autoload -Uz select-word-style
elect-word-style default
zstyle ':zle:*' word-chars " ./:;@="
zstyle ':zle:*' word-style unspecified

