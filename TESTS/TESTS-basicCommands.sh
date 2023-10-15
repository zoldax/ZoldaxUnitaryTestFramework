#!/bin/bash

# ----------------------------------------------------------------------------------
# Script:               TESTS-basicCommands.sh
# Author:               Pascal Weber (zoldax)
# ----------------------------------------------------------------------------------

# Test definitions for basicCommands.sh

# Define a series of tests as a bash array
# Format: "Test Name|Command Option|Expected Output|Setup Commands (if any)"

tests=(
    "GROUP|Basic Commands Tests"
    "Test Hello Command|hello|Hello, World!|touch hello.txt"
    "Test Bye Command|bye|Goodbye!|touch bye.txt"
    "Test Invalid Command|invalid|Unknown command.|"
)

