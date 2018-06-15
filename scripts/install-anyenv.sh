#!/bin/sh

RB_VER=2.5.1
ND_VER=v8.11.3
PY_VER=3.6.5

ANYENV_ROOT=${HOME}/.anyenv
PYENV_PLUGINS_ROOT=${ANYENV_ROOT}/envs/pyenv/plugins
PYENV_FLAGS=""
SYS_NAME=$(uname)

# Clone anyenv
git clone https://github.com/riywo/anyenv ${ANYENV_ROOT}

# Add PATH
export PATH="$HOME/.anyenv/bin:$PATH"

# Install
eval "$(anyenv init -)"

IS_INSTALLED_RB=$(rbenv version | grep ${RB_VER} | wc -l | xargs echo)
if [ ${IS_INSTALLED_RB} -eq 0 ]; then
    anyenv install -f rbenv
    ${SHELL} -lc "rbenv install -f ${RB_VER} && rbenv global ${RB_VER} && rbenv rehash"
fi

IS_INSTALLED_ND=$(ndenv version | grep ${ND_VER} | wc -l | xargs echo)
if [ ${IS_INSTALLED_ND} -eq 0 ]; then
    anyenv install -f ndenv
    ${SHELL} -lc "ndenv install -f ${ND_VER} && ndenv global ${ND_VER} && ndenv rehash"
fi

IS_INSTALLED_PY=$(pyenv version | grep ${PY_VER} | wc -l | xargs echo)
if [ ${IS_INSTALLED_PY} -eq 0 ]; then
    anyenv install -f pyenv
    if test "${SYS_NAME}" == "Darwin"; then
        PYENV_FLAGS=$(echo CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib")
    fi
    ${SHELL} -lc "${PYENV_FLAGS} pyenv install -f ${PY_VER} && pyenv global ${PY_VER} && pyenv rehash"

    # Install plugins
    git clone https://github.com/yyuu/pyenv-virtualenv.git ${PYENV_PLUGINS_ROOT}/pyenv-virtualenv
    git clone https://github.com/yyuu/pyenv-update.git ${PYENV_PLUGINS_ROOT}/pyenv-update
fi

IS_INSTALLED_J=$(anyenv version | grep jenv | wc -l | xargs echo)
if [ ${IS_INSTALLED_J} -eq 0 ]; then
    anyenv install -f jenv
    ${SHELL} -lc "jenv rehash"
fi

