#!/bin/bash
set -e -u -o pipefail

declare -r CONDA_ENV="math"

active_conda_env() {
  conda env list | grep ' \* ' | cut -f 1 -d ' '
}


main() {
  cd "$(git rev-parse --show-toplevel)"

  # conda activate notes
  # calling source activate doesn't work ... so make sure user has done it
  [[ $(active_conda_env) != "$CONDA_ENV" ]] && {
    echo "ERROR: '$CONDA_ENV' not active; did you forget 'conda activate $CONDA_ENV' ?"
    return 1
  }

  set -x
  exec jupyter notebook "$@"
}

main "$@"
