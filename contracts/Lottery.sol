pragma solidity ^0.4.18; 

contract Lottery{

	address public owner;
	
	uint256 public totalTokens;

	uint256 private winningNumber;

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
}