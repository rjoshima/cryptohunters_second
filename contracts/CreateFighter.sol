pragma solidity ^0.4.21;
import "./safemath.sol";
import "./ownable.sol";

// import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract CreateFighter is Ownable {

  event NewFighter(uint fighterId, string name, uint dna);

  /* DATA TYPE */
  struct Fighter {
    string name;
    uint dna;
    uint32 level;
    uint16 winCount;
    uint16 lossCount;
  }

  mapping (uint => address) public fighterToOwner;
  mapping (address => uint) ownerFighterCount;

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;

  /* STORAGE */
  Fighter[] fighters;

  function _createFighter(string _name, uint _dna) internal {
    uint id = fighters.push(Fighter(_name, _dna, 6, 0, 0)) - 1;
    fighterToOwner[id] = msg.sender;
    ownerFighterCount[msg.sender]++;
    NewFighter(id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    return rand % dnaModulus;
  }

  function createRandomFighter(string _name) public {
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createFighter(_name, randDna);
  }

  // function getAllFightersOfOwner(address _owner) external view returns(uint b) {
  //   uint aa = ownerFighterCount[msg.sender];
  //   b = 4;
  // }

  function getAllFightersOfOwner(address _owner) external view returns(uint[]) {
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

  function getFighter(uint256 _tokenId) external view returns (string name, uint32 level) {
    Fighter memory fighter = fighters[_tokenId];

    name = fighter.name;
    level = fighter.level;

  }

  // function getAllDTweets() external view returns (uint256[]) {
  //   return allTokens;
  // }



  uint randNonce = 0;
  uint attackVictoryProbability;

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

    
    if (myFighter.level <= targetFighter.level) {
      attackVictoryProbability = 100 / ( 1 + targetFighter.level / myFighter.level);
    } else {
      attackVictoryProbability = 100 / ( 1 - targetFighter.level / myFighter.level);
    }
    if (rand <= attackVictoryProbability) {
      myFighter.winCount++;
      myFighter.level++;

    } else {
      myFighter.winCount++;
      myFighter.lossCount++;
    }
  }

}