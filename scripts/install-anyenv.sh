#!/bin/bash

RB_VER=2.7.2
ND_VER=14.15.4
PY_VER=3.9.1

ANYENV_ROOT=${HOME}/.anyenv
PYENV_PLUGINS_ROOT=${ANYENV_ROOT}/envs/pyenv/plugins
PYENV_FLAGS=""
SYS_NAME=$(uname)

# Clone anyenv
git clone https://github.com/riywo/anyenv ${ANYENV_ROOT}

# Add PATH
export PATH="$HOME/.anyenv/bin:$PATH"

# Install
~/.anyenv/bin/anyenv init
~/.anyenv/bin/anyenv install --init --force

IS_INSTALLED_RB=$(rbenv version | grep ${RB_VER} | wc -l | xargs echo)
if [ ${IS_INSTALLED_RB} -le 1 ]; then
    anyenv install -f rbenv
    ${SHELL} -lc "rbenv install -f ${RB_VER} && rbenv global ${RB_VER} && rbenv rehash"
fi

IS_INSTALLED_ND=$(nodenv version | grep ${ND_VER} | wc -l | xargs echo)
if [ ${IS_INSTALLED_ND} -le 1 ]; then
    anyenv install -f nodenv
    ${SHELL} -lc "nodenv install -f ${ND_VER} && nodenv global ${ND_VER} && nodenv rehash"
fi

IS_INSTALLED_PY=$(pyenv version | grep ${PY_VER} | wc -l | xargs echo)
if [ ${IS_INSTALLED_PY} -le 1 ]; then
    anyenv install -f pyenv
    if [ "${SYS_NAME}" == "Darwin" ]; then
        PYENV_FLAGS=$(echo CFLAGS=\"-I$(brew --prefix openssl)/include\" LDFLAGS=\"-L$(brew --prefix openssl)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib\")
	echo "Additional pyenv flags: ${PYENV_FLAGS}"
    fi
    ${SHELL} -lc "${PYENV_FLAGS} pyenv install -f ${PY_VER} && pyenv global ${PY_VER} && pyenv rehash"

    # Install plugins
    git clone https://github.com/pyenv/pyenv-virtualenv.git ${PYENV_PLUGINS_ROOT}/pyenv-virtualenv
    git clone https://github.com/pyenv/pyenv-update.git ${PYENV_PLUGINS_ROOT}/pyenv-update
fi

IS_INSTALLED_J=$(jenv version | grep jenv | wc -l | xargs echo)
if [ ${IS_INSTALLED_J} -eq 0 ]; then
    anyenv install -f jenv
    ${SHELL} -lc "jenv rehash"
fi

