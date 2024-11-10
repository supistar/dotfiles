# For each environments
UNAME=$(uname | tr '[A-Z]' '[a-z]')
[ -f $HOME/.zsh/.zshrc_$UNAME ] && . $HOME/.zsh/.zshrc_$UNAME

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
alias vless=$(find /usr/share/vim/**/macros -name "less.sh" | tail -n 1)

# less customize
export LESS='-R -X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'
export LESSOPEN='| $(which src-hilite-lesspipe.sh) %s'
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

# Move to upper directory as ^
cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        zle reset-prompt
    else
        zle self-insert '^'
    fi
}
zle -N cdup
bindkey '\^' cdup

# For Personal libraries
export PATH=/usr/local/bin:$PATH

# For tmux scripts
export PATH=$HOME/.tmux/scripts:$PATH

# For powerline
export PATH=$HOME/.local/bin:$PATH
source $(find ${HOME}/.local/lib/python3*/site-packages/powerline/bindings/zsh/ -name "powerline.zsh" | tail -n 1)

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

# For select-word-style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " ./:;@=-_"
zstyle ':zle:*' word-style unspecified

# Enable auto-activation of virtualenv
if which pyenv > /dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
fi

GOOGLE_CLOUD_SDK_PATH="${HOME}/Git/google-cloud-sdk"

# Set python version x.y
export PYTHON_VERSION=$(python -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))')

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${GOOGLE_CLOUD_SDK_PATH}/google-cloud-sdk/path.zsh.inc" ]; then . "${GOOGLE_CLOUD_SDK_PATH}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${GOOGLE_CLOUD_SDK_PATH}/google-cloud-sdk/completion.zsh.inc" ]; then . "${GOOGLE_CLOUD_SDK_PATH}/google-cloud-sdk/completion.zsh.inc"; fi

