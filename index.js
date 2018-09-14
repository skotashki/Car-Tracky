const express = require('express')
const app = express()

app.get('/', (req, res) => {
	res.send('Search..');
})

app.get('/car/:vin', (req, res) => {
	res.send('car by vin')
})

app.get('/register', (req, res) => {
	res.send('register a car')
})

app.post('/register', (req, res) => {

})

app.listen(3000, () => { console.log("Server is listening on port 3000") })