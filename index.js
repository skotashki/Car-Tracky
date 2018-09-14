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
	let currentCarOwner;
	let deviceAddress;

	CarContract.methods.getCarDetails(vin).call( (err, res) => {
		if(!err) {
			let currentCarOwner = res[0]
			let deviceAddress = res[1]
			let mileageCounter = res[2]
			let imageHash = res[3]

			//TODO: send to the view
		}

		CarContract.methods.getCarPreviousOwnersCount(vin).call( (err, res) => {
			if(!err) {
				let ownersLength = res.toString();

				for (var i = 0; i < 1 * ownersLength; i++) {
					Contract.methods.getCarPreviousOwnersByIndex("123", i).call( (err, res) => {
						//TODO : test it wit data
						console.log(res)
					})
				}
			}
		})
	})

	res.render('car', {
		vin : vin,
		contractAddress : contractAddress,
		contractABI : contractABI		
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

app.listen(process.env.PORT || 5000, () => { console.log("Server is listening on port 5000") })