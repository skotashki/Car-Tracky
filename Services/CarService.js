const ethers = require('ethers');
const ContractInfo = require('../Config/ContractInfo');

let contractAddress = ContractInfo.getContractAddress();
let provider = ethers.providers.JsonRpcProvider("http://35.242.225.96:8545")
function searchCar(vin) {

}


module.exports = {
    searchCar,
};