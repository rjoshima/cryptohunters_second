pragma solidity ^0.4.21;
import "./safemath.sol";
import "./ownable.sol";

// import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract CreateFighter is Ownable {

  event NewFighter(uint fighterId, string name, uint dna);

  /* DATA TYPE */
  struct fighter {
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
  uint cooldownTime = 1 days;

  /* STORAGE */
  Highter[] fighters;

  function _createFighter(string _name, uint _dna) internal {
    uint id = fighters.push(Fighter(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
    fighterToOwner[id] = msg.sender;
    ownerFighterCount[msg.sender]++;
    NewFighter(id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    return rand % dnaModulus;
  }

  function createRandomFighter(string _name) public {
    require(ownerFighterCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createFighter(_name, randDna);
  }

}
