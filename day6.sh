#!/bin/bash

INPUT="./day_6_input"
SIGNAL="$(sed "1q;d" "${INPUT}")"
SIGNAL_LENGTH="${#SIGNAL}"

WINDOW_SIZE=14
for ((IDX = 0; IDX < SIGNAL_LENGTH - WINDOW_SIZE; IDX++)); do
    SUBSTRING="${SIGNAL:${IDX}:${WINDOW_SIZE}}"

    declare -A UNIQ
    for ((IDX_SUBSTRING = 0; IDX_SUBSTRING < WINDOW_SIZE; IDX_SUBSTRING++)); do
        UNIQ["${SUBSTRING:${IDX_SUBSTRING}:1}"]=0
    done

    if [[ "${#UNIQ[@]}" = "${WINDOW_SIZE}" ]]; then
        echo "$((IDX + WINDOW_SIZE))"
        break
    fi

    UNIQ=()
done
