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

	/**
	* Used to store information about the previous owners of the car. 
	* @dev PreviousOwnersInfo struct is used in the main Car struct.
	* @param previousOwnerAddress address  - The Address of the previous car owner.
    * @param timestamp uint256 - The time when the owner changed.
    * @param mileageSanpshot uint256 - The Snapshot of the car mileage.
	*/
    struct PreviousOwnersInfo {
        address previousOwnerAddress;
        uint256 timestamp;
        uint256 mileageSnapshot;
    }
    /**
	* Our main struct that hold the entire information about the car.
	* @dev Used to track everything we need.
	* @param carOwner address - The address of the current car owner.
    * @param deviceAddress address - The address of the device(car).
    * @param vin string - The car VIN.
    * @param imageHash string - A image of the Car. Beta: Stores string path to image. Idea to store IPFS hash.
	*/
	struct Car {
		address carOwner;
		address deviceAddress;
		string vin;
		uint mileageCounter;
		string imageHash;
	}
	/**
	 * Storing Device Address to Car. That way we store information about which device.
	 * @param  FirstParam address - Device Address
	 */
	mapping(address => Car) cars;
	/**
	 * We do simillar mapping for the car details. Here we mapped from string which is the 
	 * device VIN. We currently need to do that to enable the search functionality.
	 * @param  vin string - The key to the map is the Car Vin.
	 */
	mapping(string => Car) carsByVin;
	/**
	 * Storing Device Address to PreviousOwners. That way we store information which were the owners of the device.
	 * @param  FirstParam address - Device Address
	 */
	mapping(string => PreviousOwnersInfo[]) previousOwners;

	/**
	 * To start using our system we need authority to register your car.
	 * This address holds who that authority is.
	 * @param registrator address - Holding the address of the Registrator authority
	 */
	address private registrator;
	
	/**
	 * We need to provide who the Registrator is when initilizing the contract.
	 * @param _registrator address - The address of the Registrator Authority
	 */
	constructor(address _registrator) 
	public {
		registrator = _registrator;
	}	
	
	/**
	 * This modifier is used to make sure that only the Device can acess the requested functionality
	 */
	modifier onlyDevice() {
	    require(cars[msg.sender].deviceAddress == msg.sender);
	    _;
	}
	/**
	 * This modifier is used to make sure that the requested car Exists.
	 */
	modifier existingCar() {
	    require(cars[msg.sender].carOwner != 0x0);
	    _;
	}
	/**
	 * This modifier is used to make sure that the Sender of transaction is the Registrator
	 */
	modifier onlyRegistrator() {
	    require(msg.sender == registrator);
	    _;
	}
	/**
	 * This modifier is used to make sure that the Car Doesn't Exist.
	 */
	modifier onlyNewCar(address _carAddress) {
	    require(cars[_carAddress].carOwner == 0x0);
	    _;
	}
	/**
	 * Adding Mileage to the device. This is called by the Device it self.
	 * @dev - We have to modifiers. onlyDevice() and existingCar()
	 * @param _amount uint - The amount of mileage the Device has travelled.
	 */
	function addMileage(uint _amount) 
	external
	onlyDevice()
	existingCar() {
	    cars[msg.sender].mileageCounter = cars[msg.sender].mileageCounter.add(_amount);
	}
	
	/**
	 * Used by the Registrator to register the car.
	 * @dev - We have one modifier onlyNewCar(_deviceAddress) to check if the car is new
	 * @param  _carVin string  _carVin - Car VIN.
	 * @param  _deviceAddress address _deviceAddress - The Device address
	 * @param  _mileageCounter uint    _mileageCounter - Initial mileage Counter.
	 * @param  _imageHash string  _imageHash   - Beta: Path to the image. Production: IPFS Image hash
	 */
	function registerCar(string _carVin, 
	                    address _deviceAddress,
	                    uint _mileageCounter,
	                    string _imageHash)
    external
    onlyRegistrator
    onlyNewCar(_deviceAddress) {
        Car memory newCar;
        newCar.carOwner = msg.sender;
        newCar.deviceAddress = _deviceAddress;
        newCar.vin = _carVin;
        newCar.mileageCounter = _mileageCounter;
        newCar.imageHash = _imageHash;
        cars[_deviceAddress] = newCar;
        carsByVin[_carVin] = newCar;
    }
    /**
     * Used to transfer the Onwership of the car. If the car is sold
     * @dev - Here we call the private method addDetailsToPreviousOwner(_carAddress)
     * 		  Which handles the process of putting the details for previous owners
     * @param  _carAddress address _carAddress  - The Address of the Car
     * @param  _newOwner address _newOwner    - the Address of the new Car Owner
     */
    function transferOwnership(address _carAddress, address _newOwner) 
    external
    onlyRegistrator {
        addDetailsToPreviousOwner(cars[_carAddress].vin);
        cars[_carAddress].carOwner = _newOwner;
        carsByVin[cars[_carAddress].vin].carOwner = _newOwner;
    }
    /**
     * Handles the buisness logic of setting up the Data for the previous owners.
     * @param _carVin string _carVin - The Vin of the car
     */
    function addDetailsToPreviousOwner(string _carVin)
    private {
        PreviousOwnersInfo memory previousOwner;
        previousOwner.previousOwnerAddress = carsByVin[_carVin].carOwner;
        previousOwner.mileageSnapshot = carsByVin[_carVin].mileageCounter;
        previousOwner.timestamp = block.timestamp;
        previousOwners[_carVin].push(previousOwner);
    }
    
    /**
     * Getting the Mileage of a Car
     * @return mileageCount - Returns the Miles a Car has passed.
     */
    function getMileage()
    public
    view
    returns (uint) {
        return cars[msg.sender].mileageCounter;
    }
    /**
     * Returns the Details about the Car
     * @param  _carVin string _carVin - The Vin of the Car to get the information
     * @return carOwner  address- The current Owner of the Car.
     * @return deviceAddress address - The Address of the Device.
     * @return mileageCounter uint - The Mileage information about the Car.
     * @return imageHash string - The Image Path.
    */
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
    /**
     * Getting the information about previous Owners of a Car.
     * @param  _carVin string   _carVin- The Car Vin.
     * @param  _ownerIndex uint   _ownerIndex - The Index for which Owner is the request
     * @return previousOwnerAddress address  - The Previous Owner Address
     * @return timestamp  uint - The Snapshot of the Mileage when the transfer was made
     * @return timestamp  uint - When did the change of ownership occured
     */
    function getCarPreviousOwnersByIndex(string _carVin, uint _ownerIndex) 
    public
    view
    returns (address previousOwnerAddress,
            uint mileageSnapshot,
            uint timestamp)
    {
        return (previousOwners[_carVin][_ownerIndex].previousOwnerAddress,
                previousOwners[_carVin][_ownerIndex].mileageSnapshot,
                previousOwners[_carVin][_ownerIndex].timestamp);
    }
    /**
     * Giving information of how many owners did the car had.
     * @param  _carVin string _carVin  - The Car Vin
     * @return ownersCount - The Amount of previous Owners 
     */
    function getCarPreviousOwnersCount(string _carVin) 
    public
    view
    returns (uint)
    {
        return previousOwners[_carVin].length;
    }
    
}
