pragma solidity ^0.4.18; 

contract Lottery{

	address public owner;
	
	uint256 public totalTokens;
	uint256 public tokensSold;

	uint256 private winningNumber;
	address public _winnerAddress;

	bool public gameIsActive; // status of game, active or closed

	uint256 public deposit;	// total deposit of the Lottery
	bool public transferred;	// status if the deposit has been transferred

	mapping (address => uint256) public tokensOf;
	mapping (uint256 => bool) public isGuessed; // map to store if a number has been guessed
	mapping (uint256 => address) public guesser; // map to store who guessed that number
	
	function Lottery(uint256 totlTokens, uint256 winingNumber) public{
		owner = msg.sender;
		totalTokens = totlTokens;
		winningNumber = winingNumber;
		gameIsActive = true;
	}

	modifier restricted() {
    	if (msg.sender == owner) _;
  	}

	function buyToken() public payable {
		if ((tokensSold == totalTokens) || (!gameIsActive)) {	// no more tokens left to sell
			revert();	// refund the amount sent
		}

		uint256 amount = msg.value;
		uint256 tokens = amount/(1 ether);
		uint256 remaining = amount%(1 ether);

		if (tokensSold + tokens > totalTokens) { // cannot sell more than max tokens
			uint256 available = totalTokens - tokensSold;
			remaining += (tokens - available) * (1 ether); // refund the extra amount
			tokens = available;
		}

		deposit += (tokens * (1 ether));
		tokensSold += tokens;
		tokensOf[msg.sender] += tokens;
		msg.sender.transfer(remaining);
	}

	function makeGuess(uint256 guess) public {
		require(gameIsActive);
		require(tokensOf[msg.sender] > 0);	// check for token balance
		require((guess > 0) && (guess <= totalTokens)); // check for underflow/overflow
		require(!isGuessed[guess]);	// check if the number has already been taken

		isGuessed[guess] = true;
		guesser[guess] = msg.sender;
		tokensOf[msg.sender]--;
	}

	function closeGame() public restricted {
		require(gameIsActive);
		gameIsActive = false;
		calculateWinnerAddress();
	}

	function calculateWinnerAddress() private {
		require(!gameIsActive);

		if (isGuessed[winningNumber])
			_winnerAddress = guesser[winningNumber];

		else	// hypothetical case when no one selected the winning number
			_winnerAddress= 0;
	}

	function winnerAddress() public view returns (address){
		require(!gameIsActive);
		return _winnerAddress;
	}

	function getPrice() public {
		require(!gameIsActive);
		require(!transferred);	// check if already transferred
		if (_winnerAddress != 0) {	// make sure that winner has been selected
			_winnerAddress.transfer(deposit / 2);
		}

		owner.transfer(deposit / 2);
		transferred = true;
		deposit = 0;
	}
}
