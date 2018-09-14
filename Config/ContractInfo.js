function getContractOwner() {
    let ownerAddress = "0x465c88a757c8fc52704242fa7bbffbb78942d210";
    return ownerAddress;
}
function getContractAddress() {
    let address = "0xde96194e06f498b779cb1cf16dee340ba58186a1";
    return address;
}
function getContractABI() {
    let abi = [
        {
            "constant": true,
            "inputs": [],
            "name": "getMileage",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_amount",
                    "type": "uint256"
                }
            ],
            "name": "addMileage",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_carVin",
                    "type": "string"
                }
            ],
            "name": "getCarPreviousOwnersCount",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_carAddress",
                    "type": "address"
                },
                {
                    "name": "_newOwner",
                    "type": "address"
                }
            ],
            "name": "transferOwnership",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_carVin",
                    "type": "string"
                },
                {
                    "name": "_deviceAddress",
                    "type": "address"
                },
                {
                    "name": "_mileageCounter",
                    "type": "uint256"
                },
                {
                    "name": "_imageHash",
                    "type": "string"
                }
            ],
            "name": "registerCar",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_carVin",
                    "type": "string"
                }
            ],
            "name": "getCarDetails",
            "outputs": [
                {
                    "name": "carOwner",
                    "type": "address"
                },
                {
                    "name": "deviceAddress",
                    "type": "address"
                },
                {
                    "name": "mileageCounter",
                    "type": "uint256"
                },
                {
                    "name": "imageHash",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_carVin",
                    "type": "string"
                },
                {
                    "name": "_ownerIndex",
                    "type": "uint256"
                }
            ],
            "name": "getCarPreviousOwnersByIndex",
            "outputs": [
                {
                    "name": "previousOwnerAddress",
                    "type": "address"
                },
                {
                    "name": "mileageSnapshot",
                    "type": "uint256"
                },
                {
                    "name": "timestamp",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "name": "_registrator",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
        }
    ];
    return abi;
}

module.exports = {
    getContractOwner,
    getContractABI,
    getContractAddress
};
