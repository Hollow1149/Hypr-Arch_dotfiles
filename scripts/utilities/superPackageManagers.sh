#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Choose one package manager."
  echo "Usage: $0 [ --pacman | --yay]"
  exit 1
fi

case "$1" in
--pacman)
  package_manager=pacman
  fzf_args=(
    --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select'
  )
  ;;
--yay)
  package_manager=yay
  fzf_args=(
    --preview-label='alt-p: toggle description, alt-j/k: scroll,alt-b/B:toggle PKGBUILD, tab: multi-select'
    --bind 'alt-b:change-preview:yay -Gpa {1}'
    --bind 'alt-B:change-preview:yay -Siia {1}'
  )
  ;;
*)
  echo "Unknown tag '$1'"
  echo "Available tags: --pacman, --yay"
  exit 1
  ;;
esac

fzf_args+=(
  --ansi
  --multi
  --preview "$package_manager -Sii {1}"
  --preview-label-pos='bottom'
  --preview-window 'right:65%:wrap'
  --layout='reverse'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --color 'pointer:green,marker:green'
)

pkg_names=$("$package_manager" -Slq | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  echo "$pkg_names"
fi
