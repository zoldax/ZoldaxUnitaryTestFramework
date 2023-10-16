[![License](https://img.shields.io/github/license/zoldax/ZoldaxUnitaryTestFramework)](https://opensource.org/licenses/Apache-2.0) [![Commit](https://img.shields.io/github/commit-activity/t/zoldax/ZoldaxUnitaryTestFramework)](https://img.shields.io/github/commit-activity/t/zoldax/ZoldaxUnitaryTestFramework)[![Hits](https://hits.sh/github.com/silentsoft/hits.svg)](https://hits.sh/github.com/zoldax/ZoldaxUnitaryTestFramework)
# 📄 Zoldax Unitary Test Framework

A simple and personal comprehensive test suite for my applications.

## 📚 Table of Contents

- [Description](#-description)
- [Requirements](#-requirements)
- [Usage](#-usage)
- [Options](#-options)
- [basicCommands.sh Script Details](#-basiccommandssh)
    - [Commands](#commands)
- [TESTS-basicCommands.sh Script Details](#-tests-basiccommandssh)
    - [Test Structure](#test-structure)
    - [Current Test Scenarios](#current-test-scenarios)
- [How It All Ties Together](#-how-it-all-ties-together)
    - [The Primary Script: basicCommands.sh](#-the-primary-script-basiccommandssh)
    - [The Test Definitions: TESTS-basicCommands.sh](#-the-test-definitions-tests-basiccommandssh)
    - [Executing The Tests](#-executing-the-tests)
    - [Why It Matters](#-why-it-matters)
- [License](#-license)
- [Author](#-author)
- [Disclaimer](#-Disclaimer)

## 📖 Description

`ZoldaxUnitaryTestFramework.sh` is a bash-based test suite tailored to verify the behavior of my applications, ensuring the quality and robustness of the software.

## 🛠 Requirements

1. Bash Shell environment.
2. Tested applications and associated test definitions located within the `sample` and `TESTS` directories respectively.

## 🚀 Usage

```bash
./ZoldaxUnitaryTestFramework.sh [-d] [-f script_filename]
```

## 🛠 Options

**-d** : Enables debug mode, providing detailed logs during script execution.

**-f** : Specifies the filename of the script to be tested. 

# 📄 Sample provided 

## 📜 `basicCommands.sh`

This script behaves differently based on the command-line argument and the existence of certain files. 

### Commands:

1. **hello**: Outputs "Hello, World!" only if a file named `hello.txt` exists in the same directory. If the file doesn't exist, it responds with "Prerequisite not met."

2. **bye**: Responds with "Goodbye!" if a file named `bye.txt` exists in the same directory. In the absence of the file, the script will respond with "Prerequisite not met."

3. Any other command will result in "Unknown command."

## 🧪 `TESTS-basicCommands.sh`

This script is dedicated to defining a series of tests for our primary script, `basicCommands.sh`. Each test is specifically crafted to verify if `basicCommands.sh` is producing the expected output based on different input conditions and prerequisites.

### Test Structure:

Each test follows the format:
```bash
"Test Name|Command Option|Expected Output|Setup Commands (if any)"
```

- **Test Name**: Descriptive title of what the test is aiming to verify.
- **Command Option**: The command-line argument that will be passed to `basicCommands.sh`.
- **Expected Output**: What we expect `basicCommands.sh` to produce in response to the given command option.
- **Setup Commands (if any)**: These are the prerequisites that need to be executed prior to running the test. They could be commands like creating the necessary `hello.txt` or `bye.txt` files.

### Current Test Scenarios:

1. **Test Hello Command**: Aims to verify if the "Hello, World!" message is correctly displayed when the `hello.txt` file is present in the directory.
2. **Test Bye Command**: Checks if the script correctly outputs "Goodbye!" when provided with the 'bye' command and when the `bye.txt` file is present.
3. **Test Invalid Command**: This test checks the resilience of the script by sending an unknown command and expecting the script to respond with "Unknown command."

The testing framework will use these definitions to:

- Prepare the environment using the setup commands.
- Run the `basicCommands.sh` with the specified command option.
- Compare the real-time output with the expected result.
- Provide feedback on whether each test has passed or failed.

By integrating `TESTS-basicCommands.sh` with our testing framework, developers can have a streamlined process of verifying that changes or additions to `basicCommands.sh` don't inadvertently introduce errors or alter expected behavior. It serves as a safeguard, ensuring that the primary script functions reliably across different scenarios.

### Example Usage:

```bash
$ ./basicCommands.sh hello
```

## 🔄 How It All Ties Together

The integration between the primary script (`basicCommands.sh`) and the test definitions (`TESTS-basicCommands.sh`) is what makes this unitary test system effective. Let's delve deeper into how these components interact and orchestrate a robust testing process.

### 📜 The Primary Script: `basicCommands.sh`

This script is responsible for carrying out the main functionalities. Based on the input command it receives (e.g., `hello`, `bye`, etc.), it gives specific outputs. However, its output is not just dependent on the input command but also on certain prerequisites – for example, the existence of specific files like `hello.txt` or `bye.txt`.

For instance:
- When the input is `hello`, the script checks for the existence of `hello.txt`. If the file is present, it returns "Hello, World!", otherwise, "Prerequisite not met."
- For the input `bye`, it verifies the presence of `bye.txt` and acts similarly.

### 🧐 The Test Definitions: `TESTS-basicCommands.sh`

This script acts as a catalog of tests for our main script. Every test definition in this script is structured to simulate a specific scenario for `basicCommands.sh`.

For each test:
- It sets up the environment (e.g., creating necessary files).
- Executes `basicCommands.sh` with a specific command option.
- Checks the output against an expected result.

The test scenarios are designed to cover different aspects of `basicCommands.sh`, ensuring that its functionalities are sound and behave as expected across various conditions.

### 🚀 Executing The Tests

When our testing framework runs:
1. It first sources `TESTS-basicCommands.sh` to get all the test definitions.
2. For each test, it first executes any setup commands.
3. Then, it invokes `basicCommands.sh` with the specified command option.
4. The real-time output is captured and compared with the expected output.
5. The framework provides feedback, stating whether the test passed or failed.

### 🛡 Why It Matters

Unitary testing, as illustrated here, ensures that every isolated part of `basicCommands.sh` functions as expected. As developers introduce changes or additions to `basicCommands.sh`, this testing system acts as a safety net, catching potential oversights or errors before they make their way to the final version.

By consistently running these tests, we can ensure the reliability of `basicCommands.sh` across different scenarios and make confident decisions during the development phase.

# ⚖️ License

This framework is licensed under the Apache License, Version 2.0. For details, you can review the license [here](LICENSE).

# 👤 Author

**Pascal Weber (zoldax)**

Contributions are welcome! If you come across any issues or have suggestions, please raise them in the issues section or consider submitting a pull request.

# 📜 Disclaimer:

All content is without warranty of any kind. Use at your own risk. I assume no liability for the accuracy, correctness, completeness, usefulness, or any damages.
