Board peripherals support
=========================

U-Boot
------

 - DRAM
 - USART1 (STLink)
 - internal flash
 - SPI flash
 - ethernet
 - MMC
 - user button (low/high)

Linux
-----

### USART1 (STLink)

Kernel output available on `/dev/ttyS0`.

### USART6 (Arduino connector)

| Function      | Pin name     |
| ------------- |--------------|
| RX            | Arduino D0   |
| TX            | Arduino D1   |

WIP

### GPIO

Output test with onboard LED:
```
cd /sys/class/gpio
echo 129 > export
echo out > gpio129/direction
echo 1 > gpio129/value # LED turned on
echo 0 > gpio129/value # LED turned off
```

Input test with onboard user button:
```
cd /sys/class/gpio
echo 139 > export
echo in > gpio139/direction
cat gpio139/value
```

### I2C

| Function      | Pin name     |
| ------------- |--------------|
| SDA           | Arduino D14  |
| SCL           | Arduino D15  |

I2C external peripherals visible are with i2cdetect:
```
# i2cdetect 0
i2cdetect: WARNING! This program can confuse your I2C bus
Continue? [y/N] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: 40 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: 70 -- -- -- -- -- -- --
```

### To do
 - SPI flash?
 - ethernet?
 - MMC?
 - display?
 - audio?
 - GPIO?
 - USB host?
