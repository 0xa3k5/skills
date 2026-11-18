#!/usr/bin/env bash
# Fails if prototype labels leak into a build branch, or if the branch is a prototype branch.
# Usage: check-prototype-labels.sh <base-branch> [label ...]
set -euo pipefail

base="${1:?usage: check-prototype-labels.sh <base-branch> [label ...]}"
shift

branch="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$branch" == proto/* ]]; then
  echo "fail: '$branch' is a prototype branch. Prototypes don't get PRs."
  exit 1
fi

added="$(git diff "$base"...HEAD --unified=0 | grep -E '^\+[^+]' || true)"
status=0

for label in "$@"; do
  hits="$(printf '%s\n' "$added" | grep -inwF -- "$label" || true)"
  if [[ -n "$hits" ]]; then
    echo "fail: prototype label '$label' in added lines:"
    printf '%s\n' "$hits"
    status=1
  fi
done

generic="$(printf '%s\n' "$added" | grep -inE '\b(variant|direction|option|proto(type)?)[ _-]?[A-F][0-9]?\b' || true)"
if [[ -n "$generic" ]]; then
  echo "fail: generic prototype label in added lines:"
  printf '%s\n' "$generic"
  status=1
fi

[[ $status -eq 0 ]] && echo "ok: no prototype labels found."
exit $status
