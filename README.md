![Verilog](https://img.shields.io/badge/Verilog-RTL-blue)
![UART](https://img.shields.io/badge/UART-Protocol-orange)
![Digital\_Design](https://img.shields.io/badge/Digital-Design-green)
![QuestaSim](https://img.shields.io/badge/QuestaSim-Simulator-blue)

# UART_Design

## Overview

Designed a UART (Universal Asynchronous Receiver Transmitter) transceiver in Verilog supporting full-duplex serial communication. The design includes UART transmitter (TX) and receiver (RX) modules with baud rate generation, start/stop bit handling, parity checking, and serial-to-parallel data conversion.

---

## Features

### Transmitter (TX)

* Parallel-to-Serial Conversion
* Start Bit Generation
* Stop Bit Generation
* Parity Bit Generation
* Baud Rate Control

### Receiver (RX)

* Serial-to-Parallel Conversion
* Start Bit Detection
* Stop Bit Detection
* Parity Checking
* Data Reception

---

## Modules Implemented

### UART Transmitter

* Converts parallel data into serial format.
* Generates start, parity, and stop bits.

### UART Receiver

* Receives serial data stream.
* Detects frame boundaries.
* Checks parity and reconstructs parallel data.

### Baud Rate Generator

* Generates baud clock for UART communication.

---

## Test Scenarios

* Data Transmission
* Data Reception
* Full-Duplex Communication
* Parity Validation
* Back-to-Back Data Transfer

---

## Tools Used

* Verilog
* QuestaSim
* Git
* Linux

---

## Results

* Successfully implemented UART TX and RX modules.
* Verified serial data transmission and reception using simulation.
* Validated parity generation and checking.
* Confirmed correct serial-to-parallel and parallel-to-serial data conversion.

---

## Repository Structure

```text
UART_Design
│
├── rtl/
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── baud_generator.v
│
├── tb/
├── waveforms/
└── README.md
```
