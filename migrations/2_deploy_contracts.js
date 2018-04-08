var Lottery = artifacts.require("./Lottery.sol");

var totelTokens = 1000000;
var winningNumber = Math.floor(Math.random()*totelTokens + 1);

module.exports = function(deployer) {
  deployer.deploy(Lottery, totelTokens, winningNumber);
};
