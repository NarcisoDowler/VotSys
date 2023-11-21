// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DecentralizedVotingSystem is Ownable {
    enum VoteOption { None, Option1, Option2 }

    struct Voter {
        bool hasVoted;
        VoteOption vote;
    }

    mapping(address => Voter) public voters;
    uint256 public votesOption1;
    uint256 public votesOption2;

    event VoteCast(address indexed voter, VoteOption option);

    modifier hasNotVoted() {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        _;
    }


}
