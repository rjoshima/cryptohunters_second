var CreateHunter = artifacts.require("./CreateHunter.sol");

module.exports = function(deployer) {
  deployer.deploy(CreateHunter);
};