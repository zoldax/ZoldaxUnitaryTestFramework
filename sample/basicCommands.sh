#!/bin/bash
# basicCommands.sh
# A sample script that responds based on the argument provided and certain conditions (like file existence).

if [[ $1 == "hello" ]]; then
    if [[ -f "hello.txt" ]]; then
        echo "Hello, World!"
    else
        echo "Prerequisite not met."
    fi
elif [[ $1 == "bye" ]]; then
    if [[ -f "bye.txt" ]]; then
        echo "Goodbye!"
    else
        echo "Prerequisite not met."
    fi
else
    echo "Unknown command."
fi

