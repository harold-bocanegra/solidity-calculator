// SPDX-License-Identifier: MIT

pragma solidity ^0.8.35;

import "forge-std/Test.sol";

import "../src/Calculator.sol";

contract CalculatorTest is Test {

    Calculator public calculator;
    uint256 public initialResult = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    function setUp() public {
        calculator = new Calculator(initialResult, admin);
    }

    // ===== Constructor =====
    function testConstructorSetsInitialResult() public view {
        uint256 actual = calculator.result();
        assertEq(actual, initialResult);
    }

    // ===== Addition =====
    function testAddition() public {
        uint256 firstNumber = 5;
        uint256 secondNumber = 5;

        uint256 actual = calculator.addition(firstNumber, secondNumber);

        assertEq(actual, firstNumber + secondNumber);
    }

    // ===== Subtraction =====
    function testSubtraction() public {
        uint256 firstNumber = 5;
        uint256 secondNumber = 5;

        uint256 actual = calculator.subtraction(firstNumber, secondNumber);

        assertEq(actual, firstNumber - secondNumber);
    }

    // ===== Multiplier =====
    function testMultiplier() public {
        uint256 firstNumber = 5;
        uint256 secondNumber = 5;

        uint256 actual = calculator.multiplier(firstNumber, secondNumber);

        assertEq(actual, firstNumber * secondNumber);
    }

    function testCannotMultiplyTwoLargeNumbers() public {
        uint256 firstNumber = 5;
        uint256 secondNumber = 2 ** 256 - 2;

        vm.expectRevert(stdError.arithmeticError);
        calculator.multiplier(firstNumber, secondNumber);
    }

    // ===== Division =====
    function testDivisionRevertsWhenCalledByRandomUserUsingStartPrank() public {
        vm.startPrank(randomUser);

        uint256 firstNumber = 5;
        uint256 secondNumber = 5;

        vm.expectRevert(OnlyAdminAllowed.selector);
        calculator.division(firstNumber, secondNumber);

        vm.stopPrank();
    }

    function testDivisionWorksWhenCallerIsAdmin() public {
        uint256 firstNumber = 5;
        uint256 secondNumber = 5;

        vm.prank(admin);
        uint256 actual = calculator.division(firstNumber, secondNumber);

        assertEq(actual, firstNumber / secondNumber);
    }

    function testAdminDivisionRevertsWhenDividingByZero() public {
        vm.prank(admin);

        vm.expectRevert(DivisionByZero.selector);

        calculator.division(10, 0);
    }

    // ===== Fuzz tests =====
    function testFuzz_Division(uint256 firstNumber, uint256 secondNumber) public {
        vm.assume(secondNumber != 0);
        vm.prank(admin);

        uint256 actual = calculator.division(firstNumber, secondNumber);

        assertEq(actual, firstNumber / secondNumber);
    }

    function testFuzz_DivisionRevertsWhenDividingByZero(uint256 firstNumber) public {
        vm.prank(admin);

        vm.expectRevert(DivisionByZero.selector);

        calculator.division(firstNumber, 0);
    }

    function testFuzz_DivisionRevertsWhenCallerIsNotAdmin(address caller, uint256 firstNumber, uint256 secondNumber) public {
        vm.assume(caller != admin);
        vm.assume(secondNumber != 0);

        vm.prank(caller);

        vm.expectRevert(OnlyAdminAllowed.selector);

        calculator.division(firstNumber, secondNumber);
    }
}
