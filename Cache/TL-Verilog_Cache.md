# System Specifications

## Size

* Processor Word Size = 32 bits
* Instruction Cache = 16 KB Data
* Data Cache = 8 KB Data
* Memory = 48 KB, Byte Addressable

## Cache Organization

Write-through scheme followed, with 4-way Set Assocativity.

### Instruction Cache

* Block Size = 32 Bytes = 8 words
* Total Number of Lines = 512
* Total Number of Sets = 128

![alt text](https://github.com/JayDigvijay/RISC-V_Processors/blob/master/Cache/Instruction%20Cache.PNG?raw=true)

### Data Cache

* Block Size = 16 Bytes = 4 words
* Total Number of Lines = 256
* Total Number of Sets = 64

![alt text](https://github.com/JayDigvijay/RISC-V_Processors/blob/master/Cache/Data%20Cache.PNG?raw=true)

## Timing

* Hit Time = 1 clock cycles
* Miss Time = 10 clock cycles

