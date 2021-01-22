#!/bin/bash

# Use a bash function to activate conda env
#  instead of auto initialization
# ref: https://github.com/conda/conda/issues/8211
conda-init() {
  # Ported from Anaconda3 2020.08 installer
  #####################################################

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  local __conda_setup="$($HOME/opt/anaconda3/bin/conda 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "~/opt/anaconda3/etc/profile.d/conda.sh" ]; then
      . "~/opt/anaconda3/etc/profile.d/conda.sh"
    else
      export PATH="~/opt/anaconda3/bin:$PATH"
    fi
  fi
  # <<< conda initialize <<<
}

ca() {
  command -v conda &> /dev/null || conda-init
  conda activate $1
}

# Initialize conda automatically
conda-init
