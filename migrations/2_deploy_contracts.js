var Lottery = artifacts.require("./Lottery.sol");
var Web3 = require("../node_modules/web3");
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
var leftPad = require("../node_modules/left-pad");

var totelTokens = 1000000;
var winningNumber = Math.floor(Math.random()*totelTokens + 1);

// calculate sha3 of winning number
var hash = web3.sha3(leftPad((winningNumber).toString(16), 64, 0), { encoding: 'hex' });


module.exports = function(deployer) {
  deployer.deploy(Lottery, totelTokens, hash);
};
