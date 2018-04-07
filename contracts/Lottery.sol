pragma solidity ^0.4.18; 

contract Lottery{

	address public owner;
	
	uint256 public totalTokens;

	uint256 private winningNumber;

	uint256 public deposit;

	mapping (address => uint256) public tokensOf;
	mapping (uint256 => address) public guesser;
	
	function Lottery(uint256 totlTokens, uint256 winingNumber) public{
		owner = msg.sender;
		totalTokens = totlTokens;
		winningNumber = winingNumber;
	}

	modifier restricted() {
    	if (msg.sender == owner) _;
  	}

	function buyToken() public payable {
		uint256 amount = msg.value;
		uint256 tokens = amount/(1 ether);
  		uint256 remaining = amount%(1 ether);
  		deposit += tokens * (1 ether);
  		totalTokens -= tokens;
  		tokensOf[msg.sender] += tokens;
  		msg.sender.send(remaining);
  	}
}