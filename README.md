# Car Tracky

## The Problem
Have you ever tried buying a second-hand car?

And how often have you encountered sellers, who are trying to cheat you by changing the odometer data or the car service data in order to sell you a low-quality car for a high price?

If you're like me, chances are this has happened to you a lot.
In our home country, Bulgaria, we tend to say that "buying a car is a matter of luck".
And how can it be otherwise, in a market where trust seems to be utopia.

And what if you are an honest car owner who actually has a high-quality car he wants to sell?
Chances are, if your warranty period has expired, nobody would trust you about the car info you are providing.

We are living in an economy where car trading has turned into a trustless business, where both sellers and buyers are incentivized to cheat and lie.

But what if we can change the market 180 degrees?

CarTracky aims to achieve just that.

## The Product Prototype

Every car has a story...

And CarTracky is here to tell it.
It is a platform, combining the Internet of Things and Blockchain Technologies in order to bring trust into a naturally trustless market.

Utilizing the power of smart contracts and the Ethereum Blockchain, Car Tracky provides an immutable ledger of car data, where anyone can track the history of a car and verify that they are actually buying the product advertised.

What's more, we have developed a prototype arduino software and hardware, which can track the mileage data of a small robot car and report it to our smart contract periodically. Once on the blockchain, this data is immutable and no one can decrement it or modify it, other than our small IOT device.

This way, sellers can safely verify what the mileage data of the car they want to buy is and owners don't have the possibility to cheat regarding the miles their car has traveled.

## The Potential 

Currently, we are only reading the mileage data of a small robo-car. But this proof of concept shows how you can interface your real car with the ethereum blockchain and upload any kind of data your car provides.

Once sellers install this small piece of hardware on their car, they can rest assured that they will keep the price of their vehicles high for a long time and buyers can rest assured that "what they see is what they get".

This project can revolutionize the car trading industry and I would expect big car dealers to start installing such a product in their cars right out of the factory in the future.

## The Implementation

The project consists of a smart contract, written in `Solidity`, arduino software for the `Arduino Uno` and `ESP32` boards and a `JavaScript` front-end for reading the data contained in the ethereum smart contract.

### Smart Contract
The smart contract can be found in the `Contracts` directory.


### Arduino Software
The arduino software is in `arduino_code`.
It consists of two separate projects.
`uno_bluetooth_car` is the `Arduino Uno` software, controlling the smart car.
`esp32_eth_interface` is the `ESP32` software, controlling the communication with the smart contract.

The `Arduino Uno` software is the one responsible for controlling the bluetooth smart car, controlled by a mobile application.
It has management for the wheel motors, leds indicating various events occuring on the board and mileage tracking controller.
Finally, it has a software serial interface with the `ESP32` board. It uses it to forward mileage data to the `ESP32` board, which then broadcasts it to the ethereum blockchain.

The `ESP32` software is responsible for interfacing with the `CarTracky` smart contract via a modified version of the `web3-arduino` library (https://github.com/kopanitsa/web3-arduino). It also has a wifi module to communicate with the internet and use it as a communication channel for connecting to an ethereum node (By default, we use `Infura`, but for demo purposes, it is changed to an instance of a `Ganache` node hosted in a google cloud).

### The JavaScript Front-End
TODO: Complete section

### Hardware Pinout
TODO: Complete section
