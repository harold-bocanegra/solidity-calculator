// SPDX-License-Identifier: MIT

pragma solidity ^0.8.35;

/// @notice Thrown when the divisor is zero.
error DivisionByZero();

/// @notice Thrown when a non-admin account calls an admin-only function.
error OnlyAdminAllowed();

contract Calculator {

    uint256 public result;
    address public admin;

    event Addition(uint256 firstNumber, uint256 secondNumber, uint256 result);

    event Subtraction(uint256 firstNumber, uint256 secondNumber, uint256 result);

    event Multiplier(uint256 firstNumber, uint256 secondNumber, uint256 result);

    event Division(uint256 firstNumber, uint256 secondNumber, uint256 result);

    /**
     * @notice Restricts function execution to the contract admin.
     */
    modifier onlyAdmin() {
        if (msg.sender != admin) {
            revert OnlyAdminAllowed();
        }
        _;
    }

    constructor(uint256 initialResult_, address admin_) {
        result = initialResult_;
        admin = admin_;
    }

    function addition(uint256 firstNumber, uint256 secondNumber) external returns(uint256 result_) {
        result_ = firstNumber + secondNumber;
        result = result_;

        emit Addition(firstNumber, secondNumber, result_);
    }

    function subtraction(uint256 firstNumber, uint256 secondNumber) external returns(uint256 result_) {
        result_ = firstNumber - secondNumber;
        result = result_;

        emit Subtraction(firstNumber, secondNumber, result_);
    }

    function multiplier(uint256 firstNumber, uint256 secondNumber) external returns(uint256 result_) {
        result_ = firstNumber * secondNumber;
        result = result_;

        emit Multiplier(firstNumber, secondNumber, result_);
    }

    function division(uint256 firstNumber, uint256 secondNumber) external onlyAdmin returns(uint256 result_) {
        if (secondNumber == 0) {
            revert DivisionByZero();
        }
        result_ = firstNumber / secondNumber;
        result = result_;

        emit Division(firstNumber, secondNumber, result_);
    }
}
