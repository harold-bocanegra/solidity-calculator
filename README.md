# Foundry Calculator

A calculator smart contract built with Solidity and tested with Foundry as part of my blockchain development training..

The project focuses on Solidity fundamentals, smart contract testing, access control, custom errors, and fuzz testing.

## Features

The `Calculator` smart contract supports:

* Addition, subtraction, multiplication and division operations.
* Admin-restricted division using a custom modifier.
* Custom errors for gas-efficient reverts.
* Event emission for operations.
* Admin transfer functionality.
* Unit tests with Foundry.
* Fuzz testing for division logic.
* Event emission testing.

## Smart Contract Overview

### Calculator.sol

The contract includes:

### State Variables

```solidity
uint256 public result;
address public admin;
```

* `result`: Stores the last operation result.
* `admin`: Address authorized to execute restricted operations.

### Available Operations

| Function         | Description                      |
| ---------------- | -------------------------------- |
| `addition()`     | Adds two numbers                 |
| `subtraction()` | Subtracts two numbers            |
| `multiplier()`   | Multiplies two numbers           |
| `division()`     | Divides two numbers (admin only) |

## Security Features

### Access Control

The division function is protected with a custom modifier:

```solidity
modifier onlyAdmin()
```

Only the contract administrator can execute this function.

### Custom Errors

The contract uses Solidity custom errors:

```solidity
error DivisionByZero();

error OnlyAdminAllowed();
```

Benefits:

* Lower gas consumption compared with revert strings.
* More explicit error handling.

## Testing

The project includes Foundry tests covering:

* Contract initialization
* Successful arithmetic operations
* Access control restrictions
* Division by zero protection
* Overflow protection
* Fuzz testing with random inputs

## Test Examples

### Admin-only function test

The test suite verifies that:

* The admin can execute restricted functions.
* Unauthorized users are rejected.

### Fuzz testing

The project includes fuzz tests to validate the division logic with automatically generated inputs.

## Requirements

* Foundry
* Solidity ^0.8.35

## Installation

Clone the repository:

```bash
git clone <repository-url>
```

Install dependencies:

```bash
forge install
```

## Running Tests

Compile the project:

```bash
forge build
```

Run the test suite:

```bash
forge test
```

Run tests with detailed traces:

```bash
forge test -vvvv
```

## Project Structure

```
.
├── src
│   └── Calculator.sol
├── test
│   └── Calculator.t.sol
├── lib
│   └── forge-std
├── foundry.toml
└── README.md
```

## Technologies Used

* Solidity
* Foundry
* Forge
* Forge Std
* GitHub Actions

## Learning Goals

This project was created to practice:

* Writing Solidity smart contracts
* Creating unit tests with Foundry
* Using custom errors
* Implementing access control
* Understanding fuzz testing
* Following professional smart contract development workflows
