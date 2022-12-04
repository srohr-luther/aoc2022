#!/bin/bash

INPUT="./day_4_input"
readarray -t LINES <"${INPUT}"

PART1=0
PART2=0
for LINE in "${LINES[@]}"; do
    IFS=',' read -ra SPLIT <<<"${LINE}"
    IFS='-' read -ra FIRST <<<"${SPLIT[0]}"
    IFS='-' read -ra SECOND <<<"${SPLIT[1]}"
    A="${FIRST[0]}"
    B="${FIRST[1]}"
    C="${SECOND[0]}"
    D="${SECOND[1]}"

    if (((A >= C && B <= D) || (C >= A && D <= B))); then
        PART1=$((PART1 + 1))
    fi

    if (((A >= C && A <= D) || (B >= C && B <= D) || (C >= A && C <= B) || (D >= A && D <= B))); then
        echo "${A} ${B} ${C} ${D}"
        PART2=$((PART2 + 1))
    fi
done
echo "${PART1}"
echo "${PART2}"
