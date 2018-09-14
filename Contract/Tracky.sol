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
	* @param {address} previousOwnerAddress  - The Address of the previous car owner.
    * @param {uint256} timestamp - The time when the owner changed.
    * @param {uint256} mileageSanpshot - The Snapshot of the car mileage.
	*/
    struct PreviousOwnersInfo {
        address previousOwnerAddress;
        uint256 timestamp;
        uint256 mileageSnapshot;
    }
    /**
	* Our main struct that hold the entire information about the car.
	* @dev Used to track everything we need.
	* @param {address} carOwner- The address of the current car owner.
    * @param {address} deviceAddress - The address of the device(car).
    * @param {string} vin - The car VIN.
    * @param {string} imageHash - A image of the Car. Beta: Stores string path to image. Idea to store IPFS hash.
    * @param {PreviousOwnersInfo[]} previousOwners  - Stores information about all of the previous owners.
	*/
	struct Car {
		address carOwner;
		address deviceAddress;
		string vin;
		uint mileageCounter;
		string imageHash;
	    PreviousOwnersInfo[] previousOwners;
	}
	/**
	 * Storing Device Address to Car. That way we store information about which device.
	 * @param  {address} FirstParam - Device Address
	 */
	mapping(address => Car) cars;
	/**
	 * We do simillar mapping for the car details. Here we mapped from string which is the 
	 * device VIN. We currently need to do that to enable the search functionality.
	 * @param  {string} vin - The key to the map is the Car Vin.
	 */
	mapping(string => Car) carsByVin;

	/**
	 * To start using our system we need authority to register your car.
	 * This address holds who that authority is.
	 * @param {address} registrator - Holding the address of the Registrator authority
	 */
	address private registrator;
	
	/**
	 * We need to provide who the Registrator is when initilizing the contract.
	 * @param {address} _registrator - The address of the Registrator Authority
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
	 * @param {uint} _amount - The amount of mileage the Device has travelled.
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
	 * @param  {string} string  _carVin - Car VIN.
	 * @param  {address} address _deviceAddress - The Device address
	 * @param  {uint} uint    _mileageCounter - Initial mileage Counter.
	 * @param  {string} string  _imageHash   - Beta: Path to the image. Production: IPFS Image hash
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
     * @param  {address} address _carAddress  - The Address of the Car
     * @param  {address} address _newOwner    - the Address of the new Car Owner
     */
    function transferOwnership(address _carAddress, address _newOwner) 
    external
    onlyRegistrator {
        addDetailsToPreviousOwner(_carAddress);
        cars[_carAddress].carOwner = _newOwner;
        carsByVin[cars[_carAddress].vin].carOwner = _newOwner;
    }
    /**
     * Handles the buisness logic of setting up the Data for the previous owners.
     * @param {address} address _carAddress - The address of the car
     */
    function addDetailsToPreviousOwner(address _carAddress)
    private {
        PreviousOwnersInfo memory previousOwner;
        previousOwner.previousOwnerAddress = cars[_carAddress].carOwner;
        previousOwner.mileageSnapshot = cars[_carAddress].mileageCounter;
        previousOwner.timestamp = block.timestamp;
        cars[_carAddress].previousOwners.push(previousOwner);
        carsByVin[cars[_carAddress].vin].previousOwners.push(previousOwner);
    }
    
    /**
     * Getting the Mileage of a Car
     * @return {uint} - Returns the Miles a Car has passed.
     */
    function getMileage()
    external
    view
    returns (uint) {
        return cars[msg.sender].mileageCounter;
    }
    /**
     * Returns the Details about the Car
     * @param  {string} string _carVin - The Vin of the Car to get the information
     * @return {address} carOwner - The current Owner of the Car.
     * @return {address} deviceAddress - The Address of the Device.
     * @return {uint} mileageCounter - The Mileage information about the Car.
     * @return {string} imageHash - The Image Path.
    */
    function getCarDetails(string _carVin) 
    external
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
     * @param  {string} string _carVin  - The Car Vin.
     * @param  {uint} uint   _ownerIndex - The Index for which Owner is the request
     * @return {address}  previousOwnerAddress - The Previous Owner Address
     * @return {uint}  mileageSnapshot - The Snapshot of the Mileage when the transfer was made
     * @return {uint}  timestamp - When did the change of ownership occured
     */
    function getCarPreviousOwnersByIndex(string _carVin, uint _ownerIndex) 
    external
    view
    returns (address previousOwnerAddress,
            uint mileageSnapshot,
            uint timestamp)
    {
        return (carsByVin[_carVin].previousOwners[_ownerIndex].previousOwnerAddress,
                carsByVin[_carVin].previousOwners[_ownerIndex].mileageSnapshot,
                carsByVin[_carVin].previousOwners[_ownerIndex].timestamp);
    }
    /**
     * Giving information of how many owners did the car had.
     * @param  {string} string _carVin  - The Car Vin
     * @return {uint} - The Amount of previous Owners that the car had
     */
    function getCarPreviousOwnersCount(string _carVin) 
    external
    view
    returns (uint)
    {
        return carsByVin[_carVin].previousOwners.length;
    }
    
}
