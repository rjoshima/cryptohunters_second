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
    uint id = fighters.push(Fighter(_name, _dna, 1, 0, 0)) - 1;
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

  function getFighter(uint256 _tokenId) external view returns (string name) {
    Fighter memory fighter = fighters[_tokenId];

    name = fighter.name;
  }
}
