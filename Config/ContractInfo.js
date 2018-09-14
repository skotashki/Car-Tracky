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
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "_from",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "name": "_amount",
                    "type": "uint256"
                }
            ],
            "name": "LogDonationReceived",
            "type": "event"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_type",
                    "type": "bytes10"
                },
                {
                    "name": "_index",
                    "type": "uint256"
                }
            ],
            "name": "adopt",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
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
            "name": "giveDonation",
            "outputs": [],
            "payable": true,
            "stateMutability": "payable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_type",
                    "type": "bytes10"
                },
                {
                    "name": "_name",
                    "type": "bytes10"
                },
                {
                    "name": "_age",
                    "type": "uint256"
                },
                {
                    "name": "_breed",
                    "type": "bytes20"
                },
                {
                    "name": "_gender",
                    "type": "bytes6"
                },
                {
                    "name": "_imageHash",
                    "type": "string"
                }
            ],
            "name": "leaveForAdoption",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_type",
                    "type": "bytes10"
                },
                {
                    "name": "_index",
                    "type": "uint256"
                }
            ],
            "name": "removePet",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [],
            "name": "retrieveFunds",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [],
            "name": "returnPet",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "ableToAdopt",
            "outputs": [
                {
                    "name": "",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "ableToReturn",
            "outputs": [
                {
                    "name": "",
                    "type": "bool"
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
                    "name": "_index",
                    "type": "uint256"
                }
            ],
            "name": "getCategoryName",
            "outputs": [
                {
                    "name": "name",
                    "type": "bytes10"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "getLastAdoptedPetInfo",
            "outputs": [
                {
                    "name": "name",
                    "type": "bytes10"
                },
                {
                    "name": "age",
                    "type": "uint256"
                },
                {
                    "name": "breed",
                    "type": "bytes20"
                },
                {
                    "name": "gender",
                    "type": "bytes6"
                },
                {
                    "name": "petOwner",
                    "type": "address"
                },
                {
                    "name": "petType",
                    "type": "bytes10"
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
            "inputs": [],
            "name": "getNumberOfCategories",
            "outputs": [
                {
                    "name": "count",
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
                    "name": "_type",
                    "type": "bytes10"
                }
            ],
            "name": "getNumberOfPetsInType",
            "outputs": [
                {
                    "name": "count",
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
                    "name": "_type",
                    "type": "bytes10"
                },
                {
                    "name": "_index",
                    "type": "uint256"
                }
            ],
            "name": "getPetImageHash",
            "outputs": [
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
                    "name": "_type",
                    "type": "bytes10"
                },
                {
                    "name": "_index",
                    "type": "uint256"
                }
            ],
            "name": "getPetInfo",
            "outputs": [
                {
                    "name": "name",
                    "type": "bytes10"
                },
                {
                    "name": "age",
                    "type": "uint256"
                },
                {
                    "name": "breed",
                    "type": "bytes20"
                },
                {
                    "name": "gender",
                    "type": "bytes6"
                },
                {
                    "name": "petOwner",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "getTotalDonations",
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
            "name": "totalDonations",
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
    getContractOwner,
    getContractABI,
    getContractAddress
};
