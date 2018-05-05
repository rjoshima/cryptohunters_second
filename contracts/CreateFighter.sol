pragma solidity ^0.4.21;

// import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

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
      myFighter.lossCount++;
    }
  }

}




    // function tokensOfOwner(address _owner) external view returns(uint256[] ownerTokens) {
    //     uint256 tokenCount = balanceOf(_owner);

    //     if (tokenCount == 0) {
    //         // Return an empty array
    //         return new uint256[](0);
    //     } else {
    //         uint256[] memory result = new uint256[](tokenCount);
    //         uint256 totalCats = totalSupply();
    //         uint256 resultIndex = 0;

    //         // We count on the fact that all cats have IDs starting at 1 and increasing
    //         // sequentially up to the totalCat count.
    //         uint256 catId;

    //         for (catId = 1; catId <= totalCats; catId++) {
    //             if (kittyIndexToOwner[catId] == _owner) {
    //                 result[resultIndex] = catId;
    //                 resultIndex++;
    //             }
    //         }

    //         return result;
    //     }
    // }