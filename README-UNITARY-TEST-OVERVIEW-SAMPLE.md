# 🧪 Unitary Tests Overview

This document provides an overview of the unitary tests defined for the `basicCommands.sh` script. These tests are tailored to ensure the script behaves as expected based on different inputs and environmental conditions.

## 📚 Table of Contents

- [About the Testing Script](#about-the-testing-script)
- [Test Format](#test-format)
- [List of Tests](#list-of-tests)

## 📖 About the Testing Script

**Script**: `TESTS-basicCommands.sh`  
**Author**: Pascal Weber (zoldax)

The purpose of this script is to provide test definitions for the primary script `basicCommands.sh`. 

## 🔍 Test Format

Tests are structured using the following format:

```bash
"Test Name|Command Option|Expected Output|Setup Commands (if any)"
```

- **Test Name**: A descriptive title of the test.
- **Command Option**: The command-line argument to be passed to `basicCommands.sh`.
- **Expected Output**: The expected output from `basicCommands.sh` for the given command option.
- **Setup Commands**: Commands required to set the environment for the test.

## 📋 List of Tests

| Test Name             | Command Option | Expected Output     | Setup Commands         |
|-----------------------|----------------|---------------------|------------------------|
| Test Hello Command    | `hello`        | `Hello, World!`     | `touch hello.txt`      |
| Test Bye Command      | `bye`          | `Goodbye!`          | `touch bye.txt`        |
| Test Invalid Command  | `invalid`      | `Unknown command.`  | None required          |

---

For more detailed information on how these tests are executed within the framework, refer to the primary documentation.
