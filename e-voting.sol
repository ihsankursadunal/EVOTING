pragma solidity >=0.5.1<0.8.0;

contract EVOTING{
    
   address owner;
    struct Voter {
        bool isVoted;
        uint8 my_candidate;
    }
    
    struct candidate {
        uint voteCount;
    }
    
    mapping(address=>Voter) voters;
    candidate[] candidates;
    
    constructor (uint candidate_num) public {
        owner = msg.sender;
        for(uint i = 0 ; i<candidate_num; i++){
            candidates.push(candidate(0));
        }
    }
    
    modifier notOwner(){
        require(msg.sender != owner);
        _;
    }
    
    modifier notVoted(){
        require(!voters[msg.sender].isVoted);
        _;
    }
    
    
    function vote(uint8 index) public notVoted {
        if(index >= candidates.length){
            return;
        }else{
            voters[msg.sender].isVoted = true;
            voters[msg.sender].my_candidate = index;
            candidates[index].voteCount += 1;  
        }
    }
        
    function atTheMoment(uint a) public view returns(int){
        if(a>=candidates.length){
            return -1;
        }
        return int(candidates[a].voteCount);
    }
    
    function result() public view returns (uint256 winer, uint8 my_candidate) {
        uint256 max = 0;
        winer=0;
        for (uint8 cand = 0; cand < candidates.length;cand++){
            if (candidates[cand].voteCount > max){
                max = candidates[cand].voteCount;
                winer = cand;
            }
    
        }
        my_candidate = voters[msg.sender].my_candidate;
    }
    
}
