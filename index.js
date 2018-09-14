const express = require('express')
const app = express()
const path = require("path")
const bodyParser = require('body-parser')

//bodyparser for processing post data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
})); 

//Web3 for blockchain interaction
const Web3 = require('web3');
const web3 = new Web3('http://35.242.225.96:8545')

const config = require('./Config/ContractInfo.js')
const contractAddress = '0x7c164532362e967201af1bbf17540c5f1853b03f'
const CarContract = new web3.eth.Contract(
	config.getContractABI(),
	config.getContractAddress())

//Static resources for express
app.use(express.static('public'))
app.use(express.static('node_modules'))

app.get('/', (req, res) => {
	res.sendFile(path.join(__dirname + '/index.html'))
})

app.get('/car/:vin', async (req, res) => {
	
	CarContract.methods.getCarDetails("123").call( (err, res) => {
		if(!err) {
			let currentCarOwner = res[0]
			let deviceAddress = res[1]
			let mileageCounter = res[2]
			let imageHash = res[3]

			//TODO: send to the view
		}

		CarContract.methods.getCarPreviousOwnersCount("123").call( (err, res) => {
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

		res.send(path.join(__dirname + '/car.ejs'))
	})
})

app.get('/register', (req, res) => {
	res.sendFile(path.join(__dirname + '/register.html'))
})

app.post('/register', (req, res) => {
	let brand = req.body.brand
	let year = req.body.year
	let mileage = req.body.mileage
	let img = req.body.img
	
	res.render(path.join(__dirname + '/register'))
})

app.listen(process.env.PORT || 5000, () => { console.log("Server is listening on port 5000") })