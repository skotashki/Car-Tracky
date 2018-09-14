const express = require('express')
const app = express()
const path = require("path")
// const CarService = require('./Services/CarService');

//test
// const Web3 = require('web3');
// const web3 = new Web3("http://35.242.225.96:8545")

// web3.eth.getBlockNumber().then(console.log)

app.use(express.static('public'))
app.use(express.static('node_modules'))

app.get('/', (req, res) => {
	res.sendFile(path.join(__dirname + '/index.html'))
})

app.get('/car/:vin', (req, res) => {
	//TODO: PROVIDE REAL VIN HERE
	// CarService.searchCar("test");
	res.sendFile(path.join(__dirname + '/car.html'))
})

app.get('/register', (req, res) => {
	res.sendFile(path.join(__dirname + '/register.html'))
})

app.post('/register', (req, res) => {

})

app.listen(3000, () => { console.log("Server is listening on port 3000") })