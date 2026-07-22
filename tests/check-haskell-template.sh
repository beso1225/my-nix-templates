#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
template_ref="path:${repo_root}#haskell"
workdir="$(mktemp -d)"
workdir="$(cd "${workdir}" && pwd -P)"
project_dir="${workdir}/project"
trap 'rm -rf "${workdir}"' EXIT

nix eval --raw "path:${repo_root}#templates.haskell.description" >/dev/null
nix flake new --template "${template_ref}" "${project_dir}"
nix flake show "path:${project_dir}" >/dev/null

nix develop "path:${project_dir}" --command bash -euo pipefail -c '
  ghc_version="$(ghc --numeric-version)"
  hls_version="$(haskell-language-server-wrapper --version)"

  ghc --version
  ghci --version
  cabal --version
  printf "%s\n" "${hls_version}"

  case "${hls_version}" in
    *"(GHC: ${ghc_version})"*) ;;
    *)
      printf "GHC/HLS version mismatch: GHC %s, %s\n" "${ghc_version}" "${hls_version}" >&2
      exit 1
      ;;
  esac
'
