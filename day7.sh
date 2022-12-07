#!/bin/bash

INPUT="./day_7_input"
REGEX="([0-9]+) .*"
CURRENT_PATH=()

declare -A MAP
while IFS= read -r LINE; do
    if [[ "$ cd .." = "${LINE:0:7}" ]]; then
        #printf '%s\n' "${CURRENT_PATH[@]}"
        unset 'CURRENT_PATH[${#CURRENT_PATH[@]}-1]'
    elif [[ "$ cd /" = "${LINE:0:6}" ]]; then
        CURRENT_PATH+=("/")
    elif [[ "$ cd" = "${LINE:0:4}" ]]; then
        CURRENT_PATH+=("${LINE:5}")
        #echo "${CURRENT_PATH[*]}"
    elif [[ "$ ls" = "${LINE:0:4}" ]]; then
        continue
    elif [[ "dir" = "${LINE:0:3}" ]]; then
        continue
    elif [[ ${LINE} =~ $REGEX ]]; then
        SIZE="${BASH_REMATCH[1]}"

        CURRENT_PATH_LENGTH="${#CURRENT_PATH[@]}"
        MAP_PATH=""
        for ((I = 0; I < CURRENT_PATH_LENGTH; I++)); do
            MAP_PATH="${MAP_PATH} ${CURRENT_PATH[${I}]}"
            CURRENT_SIZE=MAP["${MAP_PATH}"]
            CURRENT_SIZE=$((CURRENT_SIZE + SIZE))
            MAP["${MAP_PATH}"]="${CURRENT_SIZE}"
        done
    else
        echo "no match ${LINE}"
    fi
done <"$INPUT"

ACC=0
for KEY in "${!MAP[@]}"; do
    VALUE="${MAP[$KEY]}"

    if ((VALUE <= 100000)); then
        ACC=$((ACC + VALUE))
    fi
    printf "[%s]=%s\n" "$KEY" "${MAP[$KEY]}"
done
echo "${ACC}"

FREE_SPACE=$((70000000 - ${MAP[" /"]}))
echo "FREE_SPACE=${FREE_SPACE}"
NEEDED=$((30000000 - FREE_SPACE))
echo "NEEDED=${NEEDED}"

MIN=70000000
TARGET=""
for KEY in "${!MAP[@]}"; do
    VALUE="${MAP[$KEY]}"
    if ((VALUE >= NEEDED && VALUE < MIN)); then
        MIN="${VALUE}"
        TARGET="${KEY}"
    fi
done

echo "${TARGET}=${MIN}"
