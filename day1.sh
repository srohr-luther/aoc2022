#!/bin/bash
ELVES=()
INPUT="./day_1_input"
ACC=0
while IFS= read -r LINE; do
    ACC=$((ACC + LINE))
    if [ -z "${LINE}" ]; then
        ELVES+=("${ACC}")
        ACC=0
    fi
done <"$INPUT"

# shellcheck disable=SC2207
IFS=$'\n' SORTED_ELVES=($(sort -rg <<<"${ELVES[*]}"))
unset IFS

echo "${SORTED_ELVES[0]}"
echo "$((SORTED_ELVES[0] + SORTED_ELVES[1] + SORTED_ELVES[2]))"
