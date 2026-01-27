#!/bin/bash

# Use a bash function to activate conda env
#  instead of auto initialization
# ref: https://github.com/conda/conda/issues/8211
conda-init() {
  # Ported from Miniconda3 2020.08 installer
  #####################################################

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$("${HOME}/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
      . "${HOME}/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="${HOME}/miniconda3/bin:$PATH"
    fi
  fi

  unset __conda_setup
  # <<< conda initialize <<<
}

#
# Conda initialization and activate env
# -----------------------------------------------------------

ca() {
  command -v conda &> /dev/null || conda-init
  conda activate $1
}

# Initialize conda automatically
conda-init
