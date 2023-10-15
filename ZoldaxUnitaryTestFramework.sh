#!/bin/bash

# =====================================================================================
# Script Name: ZoldaxUnitaryTestFramework.sh
# Description: A simple and personal comprehensive test suite for my applications.
# Author:      Pascal Weber (zoldax)
# Usage:       ./ZoldaxUnitaryTestFramework.sh [-d] [-f script_filename]
# Options:     -d   Enable debug mode for detailed logs.
#              -f   Specify the filename of the script to test (default is NHSuite.py).
#
# Copyright 2023 Pascal Weber (zoldax)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

# =====================================================================================

# --------------------------
# Global Variables
# --------------------------
# This section declares all the global variables that the script utilizes.

DEBUG=false
# ANSI color codes for terminal output.
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"
# Counter to keep track of the test numbers.
TEST_NUMBER=0
# For final summary
PASSED_TESTS=0
FAILED_TESTS=0

# ----------------------------------------
# Special variables for the script to test
# ----------------------------------------

TESTS_FOLDER="TESTS"
# Name (and path) of the log file where error messages will be written from SCRIPT_FILENAME during test execution.
# This helps in diagnosing issues that arise during the tests.
# - To change the log file name: Modify the value to your preferred name.
# - To specify a path: Provide a relative or absolute path to your desired location.
LOGFILE="error.log"

# Path to the directory where all the essential files for the test suite are located.
# Ensure that this directory contains all the necessary files as specified in the FILES array.
SCRIPT_FOLDER="sample"

# Name of the primary test script that will be executed.
# This can be updated to point to another test script if needed.
# Alternatively, use the `-f` option when invoking the test suite script to specify a different filename.
SCRIPT_FILENAME="basicCommands.sh"

# An array of filenames required for the test suite.
# These files are expected to be present in the SCRIPT_FOLDER directory and will be copied over to the current working directory during test execution.
# - To add a new file: Add its filename to the array.
# - To remove a file: Delete its entry from the array.
# - To rename a file: Update its name in the array to match the new name.
FILES=("basicCommands.sh" "hello.txt" "bye.txt")

# --------------------------
# Utility Functions
# --------------------------
# This section contains utility/helper functions that aid in script execution.

# Print usage message
usage() {
    echo "Usage: $0 [-d] [-f script_filename]"
    echo "Options:"
    echo "  -d   Enable debug mode for detailed logs."
    echo "  -f   Specify the filename of the script to test (default is NHSuite.py)."
}

# Log debug messages with timestamps if DEBUG mode is active.
debug() {
    $DEBUG && echo "$(date "+%Y-%m-%d %H:%M:%S") [DEBUG] $@"
}

# Timestamp printing function.
print_timestamp() {
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] $1"
}

# --------------------------
# Parse Script Arguments
# --------------------------
# This section is responsible for parsing the arguments passed to the script.

while getopts ":dhf:" opt; do
    case $opt in
        d) DEBUG=true ;;
        f) SCRIPT_FILENAME="$OPTARG" ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

# Reset conditions to default.
reset_conditions() {

    if [[ ! -d "$SCRIPT_FOLDER" ]]; then
        echo "Error: Suite folder $SCRIPT_FOLDER does not exist. Please check the path."
        exit 1
    fi

    for file in "${FILES[@]}"; do
        debug "Deleting $file..."
        rm -f "$file"
    done

    for file in "${FILES[@]}"; do
        local src="$SCRIPT_FOLDER/$file"
        if [[ -e "$src" ]]; then
            debug "Copying $src to current location..."
            cp "$src" .
        else
            debug "$src missing, skipping."
        fi
    done
}

# Execute individual tests.
run_test() {
    local testname="$1"
    local test_option="$2"
    local expected_output="$3"
    local expected_log="$3"

    ((TEST_NUMBER++))

    debug "Executing: ./$SCRIPT_FILENAME $test_option"
    result=$(echo "OUTPUT:" && ./$SCRIPT_FILENAME $test_option 2>&1)
    debug "$result"
    log2file=$(echo "ERROR LOG:" && awk '{ arr[NR]=$0 } END { for(i=NR-4; i<=NR; i++) print arr[i] }' error.log 2>&1)
    debug "$log2file"

    if [[ -n "$expected_log" ]]; then
        if ! grep -q "$expected_log" "$LOGFILE"; then
            if [[ "$result" != *"$expected_output"* ]]; then
                echo -e "OUTPUT CLI/LOG : $testname ${RED}FAILED${RESET}: No expected output in CLI/log"
                ((FAILED_TESTS++))
                return
            fi
        fi
    else
        if [[ "$result" != *"$expected_output"* ]]; then
            echo -e "OUTPUT CLI : $testname ${RED}FAILED${RESET}: No expected output"
            ((FAILED_TESTS++))
            return
        fi
    fi

    echo -e "$testname ${GREEN}PASSED${RESET}"
    ((PASSED_TESTS++))
}

# Run a series of commands.
execute_commands() {
    local -n cmd_array=$1
    for cmd in "${cmd_array[@]}"; do
        debug "Executing: $cmd"
        eval "$cmd"
    done
}

# Display test summary.
display_summary() {
    echo "---------------------------------------------------------------------------------------"
    echo "                                 TEST SUMMARY                                          "
    echo "---------------------------------------------------------------------------------------"
    echo -e "Total Tests: $(($PASSED_TESTS + $FAILED_TESTS))"
    echo -e "Passed: ${GREEN}$PASSED_TESTS${RESET}"
    echo -e "Failed: ${RED}$FAILED_TESTS${RESET}"
    echo "---------------------------------------------------------------------------------------"
}

# Main script function.
main() {


    # Source the TESTS file based on the SCRIPT_FILENAME
    if [[ -f "$TESTS_FOLDER/TESTS-$SCRIPT_FILENAME" ]]; then
        source "$TESTS_FOLDER/TESTS-$SCRIPT_FILENAME"
    else
        echo "Error: $TESTS_FOLDER/TESTS-$SCRIPT_FILENAME not found."
        exit 1
    fi

    # Let's begin ...
    print_timestamp "Starting tests..."
    eval "touch $LOGFILE"
    for test_data in "${tests[@]}"; do
        IFS='|' read -r -a parts <<< "$test_data"
        if [[ "${parts[0]}" == "GROUP" ]]; then
            echo "---------------------------------------------------------------------------------------"
            echo "################################ ${parts[1]} ###################################"
            echo "---------------------------------------------------------------------------------------"
            continue
        fi
        local test_name="${parts[0]}"
        local test_option="${parts[1]}"
        local expected_output="${parts[2]}"
        local setup_command="${parts[3]}"
        debug "Setup: $setup_command"
        eval "$setup_command"
        run_test "$test_name" "$test_option" "$expected_output"
        reset_conditions
    done

    # Display Summary
    display_summary

    print_timestamp "Tests completed..."
}

# Run the main function.
main "$@"

