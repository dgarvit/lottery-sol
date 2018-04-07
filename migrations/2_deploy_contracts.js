var Lottery = artifacts.require("./Lottery.sol");
var winningNumber = Math.floor(1 + Math.random()*1000000);
module.exports = function(deployer) {
  deployer.deploy(Lottery, web3.sha3(winningNumber));
};
