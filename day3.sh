#!/bin/bash

function priority() {
    letter="${1}"
    if [[ $letter =~ [a-z] ]]; then
        X=$(printf '%d' "'${letter}")
        echo $((X - 96))
    elif [[ $letter =~ [A-Z] ]]; then
        X=$(printf '%d' "'${letter}")
        echo $((X - 38))
    fi
}

function common() {
    FIRST="${1}"
    SECOND="${2}"
    # shamelessly taken from stackoverflow but now I know that comm and fold exists
    comm -12 <(fold -w1 <<<"${FIRST}" | sort -u) <(fold -w1 <<<"${SECOND}" | sort -u) | tr -d '\n'
}

INPUT="./day_3_input"

ACC=0
while IFS= read -r LINE; do
    LENGTH="${#LINE}"
    FIRST="${LINE:0:$((LENGTH / 2))}"
    SECOND="${LINE:$((LENGTH / 2))}"

    COMMON="$(common "${FIRST}" "${SECOND}")"
    for ((i = 0; i < ${#COMMON}; i++)); do
        PRIORITY="$(priority "${COMMON:$i:1}")"
        ACC=$((ACC + PRIORITY))
    done
done <"$INPUT"
echo "${ACC}"

ACC=0
LINES="$(wc -l <"${INPUT}")"
for ((LINE = 0; LINE < LINES; LINE += 3)); do
    SED_LINE_1=$((LINE + 1))
    SED_LINE_2=$((LINE + 2))
    SED_LINE_3=$((LINE + 3))
    X="$(sed "${SED_LINE_1}q;d" day_3_input)"
    Y="$(sed "${SED_LINE_2}q;d" day_3_input)"
    Z="$(sed "${SED_LINE_3}q;d" day_3_input)"
    XY=$(common "${X}" "${Y}")
    XYZ=$(common "${XY}" "${Z}")
    PRIORITY="$(priority "${XYZ}")"
    ACC=$((ACC + PRIORITY))
done
echo "${ACC}"
