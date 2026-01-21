#!/bin/bash

#
# Git tag, git push --tags, and publish to PyPI
# -----------------------------------------------------------

gpp(){
  local version
  local private

  if [[ -f "setup.py" ]]; then
    version=$(echo "from setup import __version__\nprint(__version__)" | python) || version=""
    private=$(echo "import setup\nprint('private' in dir(setup))" | python)
  fi

  # Check if project is marked as private
  if [[ $private = "True" ]]; then
    echo "Project marked as > PRIVATE <, skip publishing to PyPI"

    git tag $version &&
    gp --tags

    return $?
  fi

  if make publish; then
    echo "publish successfully"
  else
    echo "publish failed"
    return 1
  fi

  # Fallback to get from `/dist` folder
  if [[ ! -n "$version" ]]; then
    if [[ -d "dist" ]]; then
      version=$(find dist -maxdepth 1 -type f -name '*-[0-9]*.[0-9]*.[0-9]*.tar.gz' | head -n 1 | sed -E 's/.*-([0-9]+\.[0-9]+\.[0-9]+)\.tar\.gz/\1/')
    fi
  fi

  if [[ ! -n "$version" ]]; then
    echo "fails to get version"
    return 1
  fi

  echo "version: $version\n"

  git tag $version &&
  gp --tags
}

pie(){
  pip install -e . --config-settings editable_mode=strict
}

# hfd: huggingface download with default local-dir = ./<repo_name>
# usage:
#   hfd foo/bar                 -> hf download foo/bar --local-dir ./bar
#   hfd foo/bar -r main         -> pass-through extra args to hf download
#   HFD_DIR=./models hfd foo/bar  -> local-dir becomes ./models/bar
#   hfd foo/bar --dir ./x       -> local-dir becomes ./x/bar
#   hfd foo/bar --name baz      -> local-dir becomes ./baz
hfd() {
  set -euo pipefail

  if [[ $# -lt 1 ]]; then
    echo "Usage: hfd <repo_id> [--dir <base_dir>] [--name <local_name>] [-- <extra hf args>]" >&2
    return 2
  fi

  local repo_id="$1"
  shift

  # Defaults
  local base_dir="${HFD_DIR:-.}"
  local local_name=""
  local -a passthrough=()

  # Parse minimal options for this wrapper
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dir)
        [[ $# -ge 2 ]] || { echo "hfd: --dir requires a value" >&2; return 2; }
        base_dir="$2"
        shift 2
        ;;
      --name)
        [[ $# -ge 2 ]] || { echo "hfd: --name requires a value" >&2; return 2; }
        local_name="$2"
        shift 2
        ;;
      --)
        shift
        passthrough+=("$@")
        break
        ;;
      *)
        passthrough+=("$1")
        shift
        ;;
    esac
  done

  # Derive local dir name from repo_id if not provided
  if [[ -z "$local_name" ]]; then
    # repo_id like foo/bar -> bar ; also handles trailing slash
    repo_id="${repo_id%/}"
    local_name="${repo_id##*/}"
  fi

  if [[ -z "$local_name" ]]; then
    echo "hfd: failed to derive local dir name from repo_id '$repo_id'" >&2
    return 2
  fi

  local target_dir="${base_dir%/}/${local_name}"

  command -v hf >/dev/null 2>&1 || { echo "hfd: 'hf' not found in PATH" >&2; return 127; }

  hf download "$repo_id" --local-dir "$target_dir" "${passthrough[@]}"
}
