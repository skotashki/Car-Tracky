const express = require('express')
const app = express()
const path = require("path")

app.use(express.static(__dirname + '/css'))

app.get('/', (req, res) => {
	res.sendFile(path.join(__dirname + '/index.html'))
})

app.get('/car/:vin', (req, res) => {
	res.sendFile(path.join(__dirname + '/car.html'))
})

app.get('/register', (req, res) => {
	res.sendFile(path.join(__dirname + '/register.html'))
})

app.post('/register', (req, res) => {

})

app.listen(3000, () => { console.log("Server is listening on port 3000") })