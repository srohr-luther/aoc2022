#!/bin/bash

INPUT="./day_5_input"
PIVOT="$(awk '! NF { print NR; exit }' "${INPUT}")"

STACKS=()
for ((LINE_NUMBER = 0; LINE_NUMBER < PIVOT - 2; LINE_NUMBER++)); do
    LINE="$(sed "$((LINE_NUMBER + 1))q;d" "${INPUT}")"

    INDEX=0
    for ((POS = 1; POS < ${#LINE}; POS += 4)); do
        if [[ "${LINE:${POS}:1}" != " " ]]; then
            STACKS[INDEX]="${STACKS[INDEX]}${LINE:${POS}:1}"
        fi
        INDEX=$((INDEX + 1))
    done
done

IDX=1
for STACK in "${STACKS[@]}"; do
    echo "${IDX} '${STACK}'"
    IDX=$((IDX + 1))
done

# which part are we solving?
IS_PART_ONE=true

REGEX="move ([0-9]+) from ([0-9]+) to ([0-9]+)"
readarray -t MOVES < <(tail -n +$((PIVOT + 1)) "${INPUT}")
for MOVE in "${MOVES[@]}"; do
    if [[ ${MOVE} =~ $REGEX ]]; then
        COUNT="${BASH_REMATCH[1]}"
        FROM="${BASH_REMATCH[2]}"
        TO="${BASH_REMATCH[3]}"

        FROM=$((FROM - 1))
        TO=$((TO - 1))

        if [ "$IS_PART_ONE" = true ]; then
            while [[ "${COUNT}" -gt 0 ]]; do
                STACK_FROM="${STACKS[FROM]}"
                STACK_TO="${STACKS[TO]}"
                ITEM="${STACK_FROM:0:1}"

                STACKS[FROM]="${STACK_FROM:1}"
                STACKS[TO]="${ITEM}${STACK_TO}"

                COUNT=$((COUNT - 1))
            done
        else
            STACK_FROM="${STACKS[FROM]}"
            STACK_TO="${STACKS[TO]}"
            ITEMS="${STACK_FROM:0:${COUNT}}"
            STACKS[FROM]="${STACK_FROM:${COUNT}}"
            STACKS[TO]="${ITEMS}${STACK_TO}"
        fi
    fi
done

echo "---"
IDX=1
for STACK in "${STACKS[@]}"; do
    echo "${IDX} '${STACK}'"
    IDX=$((IDX + 1))
done

echo "---"
RESULT=""
for STACK in "${STACKS[@]}"; do
    RESULT="${RESULT}${STACK:0:1}"
done
echo "'${RESULT}'"
