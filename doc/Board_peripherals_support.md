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

Kernel output available through `/dev/ttyS0`, kernel message:
```
40011000.serial: ttyS0 at MMIO 0x40011000 (irq = 33, base_baud = 6250000) is a stm32-usart
console [ttyS0] enabled
stm32-usart 40011000.serial: rx dma alloc failed
stm32-usart 40011000.serial: interrupt mode used for rx (no dma)
stm32-usart 40011000.serial: tx dma alloc failed
stm32-usart 40011000.serial: interrupt mode used for tx (no dma)
```

### USART6 (Arduino connector)

| Function      | Pin name     |
| ------------- |--------------|
| RX            | Arduino D0   |
| TX            | Arduino D1   |

Kernel message:
```
40011400.serial: ttyS5 at MMIO 0x40011400 (irq = 34, base_baud = 6250000) is a stm32-usart
stm32-usart 40011400.serial: rx dma alloc failed
stm32-usart 40011400.serial: interrupt mode used for rx (no dma)
stm32-usart 40011400.serial: tx dma alloc failed
stm32-usart 40011400.serial: interrupt mode used for tx (no dma)
```

Nothing outputted when sending data to the board and reading with:
```
cat /dev/ttyS5
```

Nothing coming out of the board when sending with:
```
echo test > /dev/ttyS5
```

### GPIO

Output test with onboard LED:
```
cd /sys/class/gpio
echo 129 > export
echo out > gpio129/direction
echo 1 > gpio129/value # LED turned on
echo 0 > gpio129/value # LED turned off
```

Input test with onboard user button (blue):
```
cd /sys/class/gpio
echo 139 > export
echo in > gpio139/direction
cat gpio139/value # prints 1 if the button is pressed, 0 otherwise
```

### I2C

| Function      | Pin name     |
| ------------- |--------------|
| SDA           | Arduino D14  |
| SCL           | Arduino D15  |

I2C external peripherals visible are with i2cdetect:
```
i2cdetect 0
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

### Display

Not supported

### USB host

To be checked

### SPI flash

To be checked

### Ethernet

To be checked

### MMC

To be checked

### Audio

To be checked
