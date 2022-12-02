#!/bin/bash

# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors
# 1 for Rock, 2 for Paper, and 3 for Scissors
# X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win

INPUT="./day_2_input"
ACC=0
while IFS= read -r LINE; do
    case "${LINE}" in
    "A X")
        ACC=$((ACC + 4))
        ;;
    "A Y")
        ACC=$((ACC + 8))
        ;;
    "A Z")
        ACC=$((ACC + 3))
        ;;
    "B X")
        ACC=$((ACC + 1))
        ;;
    "B Y")
        ACC=$((ACC + 5))
        ;;
    "B Z")
        ACC=$((ACC + 9))
        ;;
    "C X")
        ACC=$((ACC + 7))
        ;;
    "C Y")
        ACC=$((ACC + 2))
        ;;
    "C Z")
        ACC=$((ACC + 6))
        ;;
    esac
done <"$INPUT"

echo "${ACC}"

# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors
# 1 for Rock, 2 for Paper, and 3 for Scissors
# X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win

INPUT="./day_2_input"
ACC=0
while IFS= read -r LINE; do
    case "${LINE}" in
    "A X")
        ACC=$((ACC + 3))
        ;;
    "A Y")
        ACC=$((ACC + 4))
        ;;
    "A Z")
        ACC=$((ACC + 8))
        ;;
    "B X")
        ACC=$((ACC + 1))
        ;;
    "B Y")
        ACC=$((ACC + 5))
        ;;
    "B Z")
        ACC=$((ACC + 9))
        ;;
    "C X")
        ACC=$((ACC + 2))
        ;;
    "C Y")
        ACC=$((ACC + 6))
        ;;
    "C Z")
        ACC=$((ACC + 7))
        ;;
    esac
done <"$INPUT"

echo "${ACC}"