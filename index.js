const express = require('express')
const app = express()
const path = require("path")
const bodyParser = require('body-parser')

//bodyparser for processing post data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
})); 

app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

//Web3 for blockchain interaction
const Web3 = require('web3');
const web3 = new Web3('http://35.242.225.96:8545')

const config = require('./Config/ContractInfo.js')

const contractAddress = config.getContractAddress();
const contractABI = config.getContractABI();
const CarContract = new web3.eth.Contract(
	contractABI, contractAddress)

//Static resources for express
app.use(express.static('public'))
app.use(express.static('node_modules'))

app.get('/', (req, res) => {
	res.render('index')
})

app.get('/car/:vin', async (req, res) => {
	let vin = req.params.vin;

	var details = CarContract.methods.getCarDetails(vin)
		.call({
			gasLimit: 250000, value:0, gas: 500000
		}, function (err, result) {
			//console.log(err);
			console.log(result);
		}
		).catch(function (error) {
			///console.log(error);
        });

	let currentCarOwner = details[0];
	let deviceAddress = details[1];
	let mileageCounter = details[2];
	let imageHash = details[3];	

	let previousOwners = await CarContract.methods.getCarPreviousOwnersCount(vin).call()

	for (var i = 0; i < previousOwners; i++) {
        let owner = await CarContract.methods.getCarPreviousOwnersByIndex(vin, i)
    }
	
	res.render('car', {
		vin : vin,
		contractAddress : contractAddress		
	})
})

app.get('/register', (req, res) => {
	res.render('register')
})

app.post('/register', (req, res) => {
	let brand = req.body.brand
	let year = req.body.year
	let mileage = req.body.mileage
	let img = req.body.img
	let device_id = req.body.device_id
	let vin = req.body.vin

	// CarContract.methods.registerCar(vin, device_id, mileage, img)
	
	res.render('/register')
})

app.listen(process.env.PORT || 3000, () => { console.log("Server is listening on port 5000") })