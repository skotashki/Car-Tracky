pragma solidity ^0.4.24;
/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, reverts on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b);

    return c;
  }

  /**
  * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0); // Solidity only automatically asserts when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
  * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a);
    uint256 c = a - b;

    return c;
  }

  /**
  * @dev Adds two numbers, reverts on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a);

    return c;
  }

  /**
  * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
  * reverts when dividing by zero.
  */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b != 0);
    return a % b;
  }
}
/**
 * The Tracky contract that stores information about cars...
 */
contract Tracky {
using SafeMath for uint;
	struct Car {
		address carOwner;
		address deviceAddress;
		string vin;
		uint mileageCounter;
		string imageHash;
	}
	
	mapping(address => Car) cars;
	mapping(string => Car) carsByVin;

	address private registrator;
	
	constructor(address _registrator) 
	public {
		registrator = _registrator;
	}	
	
	modifier onlyDevice() {
	    require(cars[msg.sender].deviceAddress == msg.sender);
	    _;
	}
	modifier existingCar() {
	    require(cars[msg.sender].carOwner != 0x0);
	    _;
	}
	
	modifier onlyRegistrator() {
	    require(msg.sender == registrator);
	    _;
	}
	
	modifier onlyNewCar(address _carAddress) {
	    require(cars[_carAddress].carOwner == 0x0);
	    _;
	}
	
	function addMileage(uint _amount) 
	public
	onlyDevice()
	existingCar() {
	    cars[msg.sender].mileageCounter = cars[msg.sender].mileageCounter.add(_amount);
	}
	
	function registerCar(string _carVin, 
	                    address _deviceAddress,
	                    uint _mileageCounter,
	                    string _imageHash)
    public
    onlyRegistrator
    onlyNewCar(_deviceAddress) {
        Car memory newCar = Car({
        carOwner: msg.sender,
        deviceAddress: _deviceAddress,
        vin: _carVin,
        mileageCounter: _mileageCounter,
        imageHash: _imageHash
        });
        cars[_deviceAddress] = newCar;
        carsByVin[_carVin] = newCar;
    }
    
    function transferOwnership(address _carAddress, address _newOwner) 
    public
    onlyRegistrator {
        cars[_carAddress].carOwner = _newOwner;
        carsByVin[cars[_carAddress].vin].carOwner = _newOwner;
    }
    
    
    function getMileage()
    public
    view
    returns (uint) {
        return cars[msg.sender].mileageCounter;
    }
    
    function getCarDetails(string _carVin) 
    public
    view
    returns (address carOwner, 
            address deviceAddress,
	        uint mileageCounter,
	        string imageHash)
    {
        Car memory currentCar = carsByVin[_carVin];
        return (currentCar.carOwner,
                currentCar.deviceAddress,
                currentCar.mileageCounter,
                currentCar.imageHash);
    }
    
    
}
