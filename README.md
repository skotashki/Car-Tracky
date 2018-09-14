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

### The JavaScript Front-End
TODO: Complete section

### Arduino Software
The arduino software is in `arduino_code`.
It consists of two separate projects.
`uno_bluetooth_car` is the `Arduino Uno` software, controlling the smart car.
`esp32_eth_interface` is the `ESP32` software, controlling the communication with the smart contract.

The `Arduino Uno` software is the one responsible for controlling the bluetooth smart car, controlled by a mobile application.
It has management for the wheel motors, leds indicating various events occuring on the board and mileage tracking controller.
Finally, it has a software serial interface with the `ESP32` board. It uses it to forward mileage data to the `ESP32` board, which then broadcasts it to the ethereum blockchain.

The `ESP32` software is responsible for interfacing with the `CarTracky` smart contract via a modified version of the `web3-arduino` library (https://github.com/kopanitsa/web3-arduino). It also has a wifi module to communicate with the internet and use it as a communication channel for connecting to an ethereum node (By default, we use `Infura`, but for demo purposes, it is changed to an instance of a `Ganache` node hosted in a google cloud).

### Hardware
The hardware is based on a modified version of the `Keyestudio bluetooth smart car`. 
Details about this product can be found here: http://wiki.keyestudio.com/index.php/Ks0159_keyestudio_Desktop_Bluetooth_Mini_Smart_Car

The project which has been used as a basis is http://wiki.keyestudio.com/index.php/Ks0159_keyestudio_Desktop_Bluetooth_Mini_Smart_Car#Project_3:_Bluetooth_smart_car

What we have added to it is a connection to a `ESP32` Dev Module (https://www.espressif.com/en/products/hardware/esp32-devkitc/overview). Also, we have removed the three proximity sensors and the three line-tracking sensors as they are not needed for this project.

In order to connect the `Arduino Uno` and the `ESP32` Module, we are using a logic level converter (https://www.sparkfun.com/products/12009) due to the fact that `Arduino Uno` uses a 5V working voltage, while the `ESP32` uses 3.3V voltage. In order to interface the two, we are using this component to achieve a 5V to 3.3V conversion.

The interface is realised by connecting pin 9 of the `Arduino Uno` to the RX pin of `ESP32`. The connection is intermediated by the logic level converter. On the `Arduino Uno`, we use a software serial interface (115200 Hz) with TX=pin 9, RX=pin 8 (not connected).
On the `ESP32`, we use the standard Serial interface on the same frequency.

And for supplying voltage to both `Arduino Uno` and `ESP32`, we have connected the 5V pin of the Uno to the 5V pin of the `ESP32` board.
For power supply, we are using two 3.6V lithium ion batteries (https://uk.farnell.com/ansmann/1307-0000/li-ion-battery-3-6v-2600mah/dp/2723326).

The final hardware component is a set of three LEDs. They are used for debugging purposes. Blinking upon establishing connection with WiFi, upon successful transmission of mileage data from the `Arduino Uno` to `ESP32` and upon successful publishing of a ethereum transaction with an invocation of `addMileage(uint)` with the received mileage data.

## Contributors
[Rosen Krumov] (https://github.com/rosenkrumov)
[Ivan Abadzhiev] (https://github.com/ivanabadzhiev) (commits from him in this repo done by [Tendrik](https://github.com/tendrik))
[Simeon Kotashki] (https://github.com/skotashki)
[Nikolay Angelov] (https://github.com/nikolayangelov)
[Preslav Mihaylov] (https://github.com/preslavmihaylov)
