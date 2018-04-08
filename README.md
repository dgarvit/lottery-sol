# lottery-sol
Simple lottery contract in solidity implemented using truffle framework.


#### Deployment instructions:
* Install the node modules
```
$ npm install
```
* Connect to an ethereum RPC client. For testing, you can use [`ganache-cli`](https://github.com/trufflesuite/ganache-cli).
* Edit the `truffle.js` file with the respective network details. Default:
```
networks: {
  development: {
    host: 'localhost',
    port: 8545,
    network_id: '*', // Match any network id
    gas: 950000
  }
}
```
* Deploy the migrations.
```
$ truffle migrate
```

### Usage
* Run the truffle console.
```
$ truffle console
```
* In the console, get instance of the deployed contract.
```
> Lottery.deployed().then(function(a){LotteryInstance = a})
```
* Call to functions:
```
Buy tokens
> LotteryInstance.buyToken({from: account, value: web3.toWei(1, "ether")})

Make guess
> LotteryInstance.makeGuess(697, {from: account})

Close game
> LotteryInstance.closeGame()

Get winning address
> LotteryInstance.winnerAddress()

Call getPrice
> LotteryInstance.getPrice()
```
