#!/bin/bash

# Use a bash function to activate conda env
#  instead of auto initialization
# ref: https://github.com/conda/conda/issues/8211
conda-init() {
  # Ported from Anaconda3 2019.07 installer
  #####################################################

  # >>> conda init >>>
  # !! Contents within this block are managed by 'conda init' !!
  local __conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
  if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
  else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
      . "/anaconda3/etc/profile.d/conda.sh"
      CONDA_CHANGEPS1=false conda activate base
    else
      \export PATH="/anaconda3/bin:$PATH"
    fi
  fi
  # <<< conda init <<<
}