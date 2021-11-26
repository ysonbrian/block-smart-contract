//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Airlines {
  address chairperson;
  struct details {
    uint256 escrow; //지불 정산을 위한 예치
    uint256 status;
    uint256 hashOfDetails;
  }
  // 항공사 어카운트 페이먼트와 회원 매핑
  mapping(address => details) public balanceDetails;
  mapping(address => uint256) membership;

  // 수정자 또는 규칙들
  modifier onlyChairPerson() {
    require(membership[msg.sender] == 1);
    _;
  }
  modifier onlyMember() {
    require(membership[msg.sender] == 1);
    _;
  }

  constructor() public payable {
    chairperson = msg.sender;
    membership[msg.sender] = 1;
    balanceDetails[msg.sender].escrow = msg.value;
  }

  function register() public payable {
    address AirlineA = msg.sender;
    membership[AirlineA] = 1;
    balanceDetails[msg.sender].escrow = msg.value;
  }

  function unregister(address payable AirlineZ) public onlyChairPerson {
    membership[AirlineZ] = 0;
    AirlineZ.transfer(balanceDetails[AirlineZ].escrow);
    balanceDetails[AirlineZ].escrow = 0;
  }

  function request(address toAirline, uint256 hashOfDetails) public onlyMember {
    if (membership[toAirline] != 1) {
      revert();
    }
    balanceDetails[msg.sender].status = 0;
    balanceDetails[msg.sender].hashOfDetails = hashOfDetails;
  }

  function response(
    address fromAirline,
    uint256 hashOfDetails,
    uint256 done
  ) public onlyMember {
    if (membership[fromAirline] != 1) {
      revert();
    }
    balanceDetails[msg.sender].status = done;
    balanceDetails[fromAirline].hashOfDetails = hashOfDetails;
  }

  function settlePayment(address payable toAirline) public payable onlyMember {
    address fromAirline = msg.sender;
    uint256 amt = msg.value;

    balanceDetails[toAirline].escrow = balanceDetails[toAirline].escrow + amt;
    balanceDetails[fromAirline].escrow =
      balanceDetails[fromAirline].escrow -
      amt;

    toAirline.transfer(amt);
  }
}
