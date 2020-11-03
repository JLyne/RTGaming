#!/usr/bin/env bash

echo "[RTGaming] State: Commit Upstream"

(
set -e

function changeLog() {
    base=$(git ls-tree HEAD $1  | cut -d' ' -f3 | cut -f1)
    cd $1 && git log --oneline ${base}...HEAD
}
paper=$(changeLog Purpur)

updated=""
logsuffix=""
if [ ! -z "$paper" ]; then
    logsuffix="$logsuffix\nPurpur Changes:\n$paper"
    if [ -z "$updated" ]; then updated="Purpur"; else updated="$updated/Purpur"; fi
fi
disclaimer="Upstream has released updates that appears to apply and compile correctly"

if [ ! -z "$1" ]; then
    disclaimer="$@"
fi

log="Updated Upstream ($updated)\n\n${disclaimer}${logsuffix}"

echo -e "$log" | git commit -F -

) || exit 1
