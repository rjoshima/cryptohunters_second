pragma solidity ^0.4.21;
import "./safemath.sol";
import "./ownable.sol";

// import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract CreateHunter is Ownable {

  event NewHunter(uint hunterId, string name, uint dna);

  /* DATA TYPE */
  struct Hunter {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  mapping (uint => address) public hunterToOwner;
  mapping (address => uint) ownerHunterCount;

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;

  /* STORAGE */
  Hunter[] hunters;

  function _createHunter(string _name, uint _dna) internal {
    uint id = hunters.push(Hunter(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
    hunterToOwner[id] = msg.sender;
    ownerHunterCount[msg.sender]++;
    NewHunter(id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    return rand % dnaModulus;
  }

  function createRandomHunter(string _name) public {
    require(ownerHunterCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createHunter(_name, randDna);
  }

}
