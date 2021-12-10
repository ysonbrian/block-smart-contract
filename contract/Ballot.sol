// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.10;

contract Ballot {
  struct Voter {
    uint256 weight;
    bool voted;
    uint256 vote;
  }

  struct Proposal {
    uint256 voteCount;
  }

  address chairperson;
  mapping(address => Voter) voters;
  Proposal[] proposals;

  enum Phase {
    Init,
    Regs,
    Vote,
    Done
  }
  Phase public state = Phase.Init;

  modifier validPhase(Phase reqPhase) {
    require(state == reqPhase);
    _;
  }

  modifier onlyChair() {
    require(msg.sender == chairperson);
    _;
  }

  constructor(uint256 numProposals) public {
    chairperson = msg.sender;
    voters[chairperson].weight = 2;
    for (uint256 prop = 0; prop < numProposals; prop++) {
      proposals.push(Proposal(0));
    }
    state = Phase.Regs;
  }

  function changeState(Phase x) public onlyChair {
    if (msg.sender != chairperson) revert();
    if (x < state) revert();
    state = x;
  }

  function register(address voter) public validPhase(Phase.Regs) onlyChair {
    // if(voters[voter].voted) revert();
    require(!voters[voter].voted);
    voters[voter].weight = 1;
    // voters[voter].voted = false;
  }

  function vote(uint256 toProposal) public validPhase(Phase.Vote) {
    Voter memory sender = voters[msg.sender];
    // if (sender.voted || toProposal >= proposals.length) revert();
    require(!sender.voted);
    require(toProposal < proposals.length);
    sender.voted = true;
    sender.vote = toProposal;
    proposals[toProposal].voteCount += sender.weight;
  }

  function reqWinner()
    public
    view
    validPhase(Phase.Done)
    returns (uint256 winningProposal)
  {
    uint256 winningVoteCount = 0;
    for (uint256 prop = 0; prop < proposals.length; prop++) {
      if (proposals[prop].voteCount > winningVoteCount) {
        winningVoteCount = proposals[prop].voteCount;
        winningProposal = prop;
      }
    }
    assert(winningVoteCount >= 3);
  }
}
