pragma solidity >=0.5.1<0.8.0;

contract EVOTING{

   address owner;

    struct Voter {
        bool isVoted;
        uint8 my_candidate;
    }

    struct Candidate {
        uint voteCount;
    }

    mapping(address=>Voter) voters;
    Candidate[] candidates;

    constructor (uint candidate_num) public {
        owner = msg.sender;
        for(uint i = 0 ; i<candidate_num; i++){
            candidates.push(Candidate(0));
        }
    }

    function vote(uint8 index) public {
        require(!voters[msg.sender].isVoted, "You can vote only once");
        require(index < candidates.length, "Invalid candidate");
        voters[msg.sender].isVoted = true;
        voters[msg.sender].my_candidate = index;
        candidates[index].voteCount += 1;
    }

    function getCandidateVoteCount(uint a) public view returns(int){
        require(a < candidates.length, "Invalid candidate");
        return int(candidates[a].voteCount);
    }

    function result() public view returns (uint256 winner) {
        uint256 max = 0;
        winner=0;
        for (uint8 cand = 0; cand < candidates.length;cand++){
            if (candidates[cand].voteCount > max){
                max = candidates[cand].voteCount;
                winner = cand;
            }
        }
    }

}
