// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AccountsDemo {
  address public whoDeposited;
  uint256 public depositAmt;
  uint256 public accountBalance;

  function deposit() public payable {
    whoDeposited = msg.sender;
    depositAmt = msg.value;
    accountBalance = address(this).balance;
  }
}
