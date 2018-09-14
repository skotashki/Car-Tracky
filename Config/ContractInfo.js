function getContractAddress() {
    let address = "0xb726a4d48bbd1ea0b040d6038142a60a6d89e63c";
    return address;
}
function getContractABI() {
    let abi = [
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
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "timestamp",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "carVin",
                    "type": "string"
                },
                {
                    "indexed": false,
                    "name": "mileage",
                    "type": "uint256"
                }
            ],
            "name": "MileageChange",
            "type": "event"
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
            "inputs": [
                {
                    "name": "_registrator",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
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
        }
    ];
    return abi;
}

module.exports = {
    // getContractOwner,
    getContractABI,
    getContractAddress
};
