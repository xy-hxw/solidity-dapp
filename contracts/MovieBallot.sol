// SPDX-License-Identifier: MIT
pragma solidity ^0.5;

contract MovieBallot {
    
    struct Candidate {
        string name;
        uint votecount;
    }
    
    struct Voter {
        bool voted;
    }
    
    Candidate[] public candidates;
    mapping(address => Voter) public voters;
    
    constructor() public {
        candidates.push(Candidate({
            name : "hai wang",
            votecount : 0
        }));
        candidates.push(Candidate({
            name : "long mao",
            votecount : 0
        }));
        candidates.push(Candidate({
            name : "du ye",
            votecount : 0
        }));
        candidates.push(Candidate({
            name : "wang luo mi zong",
            votecount : 0
        }));
    }
    
    function voteCandidate(uint8 index) public {
        // if (voters[msg.sender].voted) {
        //     return;
        // } else {
        //     candidates[index].votecount +=1;
        //     voters[msg.sender].voted = true;
        // }
        
        require(!voters[msg.sender].voted, "have voted!");
        candidates[index].votecount +=1;
        voters[msg.sender].voted = true;
    }
    
    function isVoted () public view returns (bool) {
        return voters[msg.sender].voted;
    }
    
    function getCondidate (uint8 index) public view returns (string memory) {
        return candidates[index].name;
    }
    
    function getCount(uint8 index) public view returns (uint) {
        return candidates[index].votecount;
    }  
    
}