// SPDX-License-Identifier: MIT

pragma solidity ^0.8.35;

/// @notice Thrown when the divisor is zero.
error DivisionByZero();

/// @notice Thrown when a non-admin account calls an admin-only function.
error OnlyAdminAllowed();

/// @notice Thrown when a zero address is provided where a valid address is required.
error ZeroAddress();

/**
 * @title Calculator
 * @notice A simple calculator contract with admin-restricted division.
 * @dev Demonstrates custom errors, access control and event emissions.
 */
contract Calculator {

    uint256 public result;
    address public admin;

    /// @notice Emitted when two numbers are added.
    event Addition(uint256 firstNumber, uint256 secondNumber, uint256 result);

    /// @notice Emitted when two numbers are subtracted.
    event Subtraction(uint256 firstNumber, uint256 secondNumber, uint256 result);

    /// @notice Emitted when two numbers are multiplied.
    event Multiplication(uint256 firstNumber, uint256 secondNumber, uint256 result);

    /// @notice Emitted when two numbers are divided.
    event Division(uint256 firstNumber, uint256 secondNumber, uint256 result);

    /// @notice Emitted when the admin role is transferred.
    event AdminTransferred(address indexed previousAdmin, address indexed newAdmin);

    /**
     * @notice Restricts function execution to the contract admin.
     */
    modifier onlyAdmin() {
        if (msg.sender != admin) {
            revert OnlyAdminAllowed();
        }
        _;
    }

    /// @notice Initializes the calculator contract.
    /// @param initialResult_ Initial stored result.
    /// @param admin_ Address that will control admin-only functions.
    constructor(uint256 initialResult_, address admin_) {
        if (admin_ == address(0)) {
            revert ZeroAddress();
        }

        result = initialResult_;
        admin = admin_;
    }

    /// @notice Adds two numbers.
    /// @param firstNumber First operand.
    /// @param secondNumber Second operand.
    /// @return result_ The sum of both numbers.
    function addition(uint256 firstNumber, uint256 secondNumber) external returns(uint256 result_) {
        result_ = firstNumber + secondNumber;
        result = result_;

        emit Addition(firstNumber, secondNumber, result_);
    }

    /// @notice Subtracts two numbers.
    /// @param firstNumber First operand.
    /// @param secondNumber Second operand.
    /// @return result_ The subtraction of both numbers.
    function subtraction(uint256 firstNumber, uint256 secondNumber) external returns(uint256 result_) {
        result_ = firstNumber - secondNumber;
        result = result_;

        emit Subtraction(firstNumber, secondNumber, result_);
    }

    /// @notice Multiplies two numbers.
    /// @param firstNumber First operand.
    /// @param secondNumber Second operand.
    /// @return result_ The product of both numbers.
    function multiplier(uint256 firstNumber, uint256 secondNumber) external returns(uint256 result_) {
        result_ = firstNumber * secondNumber;
        result = result_;

        emit Multiplication(firstNumber, secondNumber, result_);
    }

    /// @notice Calculates division only for the admin.
    /// @dev Can only be called by the contract admin.
    /// @param firstNumber First operand.
    /// @param secondNumber Second operand.
    /// @return result_ The division of both numbers.
    function division(uint256 firstNumber, uint256 secondNumber) external onlyAdmin returns(uint256 result_) {
        if (secondNumber == 0) {
            revert DivisionByZero();
        }
        result_ = firstNumber / secondNumber;
        result = result_;

        emit Division(firstNumber, secondNumber, result_);
    }

    /**
     * @notice Transfers the admin role to a new account.
     * @dev Can only be called by the current contract admin.
     * @param newAdmin Address of the new admin.
     */
    function transferAdmin(address newAdmin) external onlyAdmin {
        if (newAdmin == address(0)) {
            revert ZeroAddress();
        }

        address previousAdmin = admin;

        admin = newAdmin;

        emit AdminTransferred(previousAdmin, newAdmin);
    }
}
