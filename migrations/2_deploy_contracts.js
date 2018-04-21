var CreateFighter = artifacts.require("./CreateFighter.sol");

module.exports = function(deployer) {
  deployer.deploy(CreateFighter);
};