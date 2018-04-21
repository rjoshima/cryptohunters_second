pragma solidity ^0.4.19;

import "./CreateFighter.sol";

contract FighterAttack is CreateFighter {

  uint randNonce = 0;
  uint attackVictoryProbability = 100;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
  }

  modifier onlyOwnerOf(uint _fighterId) {
    require(msg.sender == fighterToOwner[_fighterId]);
    _;
  }

  function attack(uint _fighterId, uint _targetId) external onlyOwnerOf(_fighterId) {
    Fighter storage myFighter = fighters[_fighterId];
    Fighter storage targetFighter = fighters[_targetId];
    uint rand = randMod(100);
    if (myFighter.level <= attackVictoryProbability) {
      attackVictoryProbability = 1 / ( 1 + targetFighter.level / myFighter.level) * 100;
    } else {
      attackVictoryProbability = 1 / ( 1 - targetFighter.level / myFighter.level) * 100;
    }
    if (rand <= attackVictoryProbability) {
      myFighter.winCount++;
      myFighter.level++;

    } else {
      myFighter.lossCount++;
    }
  }

  function getFightersByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerFighterCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < fighters.length; i++) {
      if (fighterToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
