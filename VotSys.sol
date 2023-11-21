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
function vote(VoteOption _vote) external hasNotVoted {
        require(_vote == VoteOption.Option1 || _vote == VoteOption.Option2, "Invalid vote option");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].vote = _vote;

        if (_vote == VoteOption.Option1) {
            votesOption1++;
        } else {
            votesOption2++;
        }

        emit VoteCast(msg.sender, _vote);
    }
 function getVoteCount() external view returns (uint256, uint256) {
        return (votesOption1, votesOption2);
    }
function resetVotes() external onlyOwner {
        votesOption1 = 0;
        votesOption2 = 0;

        // Reset voter information
        for (uint256 i = 0; i < voters.length; i++) {
            voters[i].hasVoted = false;
            voters[i].vote = VoteOption.None;
        }
    }
}
