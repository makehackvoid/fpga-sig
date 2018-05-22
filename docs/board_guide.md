# Board Guide
Created: 22 May 2018

Updated: 22 May 2018

FPGA development boards are expensive. What are some of the things you
need to consider when making a purchase?

## Goals

Ask yourself:

1. Am I simply curious or deadly serious?
2. What kind of projects would I like to build with it?
3. How deep are my pockets?

## Criteria

What features should I be looking for in a board?

### Installed Device

FPGAs are generally large TQFP or BGA type devices. Not something that can or should 
be upgraded by a hobbyist. With no upgrade path you need to get this right or face
buying another board.

Device cost is heavily driven by device features. You get what you pay for. Comparison
features include:

1. Logic Cells/LUTs (murky terminology)
1. Block RAM (bits not bytes)
1. DSP
1. Clock Management
1. PCIe
1. Gigabit Tranceivers
1. ADC

Logic cells are what makes an FPGA tick. Generally the more the better. More cells
= more function and more $$.

Block RAM tends to be in demand when either using an embedded processor or
in signal processing applications. Some is good, huge amounts are
probably not required.

DSPs allow the FPGA to number crunch fast. Like really fast. RF and video processing
applications want these resources.

Clock management allows external clock sources such as crystals to be brought into
the FPGA fabric. Functions include frequency multiplication and division as well
as phase adjustment. Whilst desirable for a hobbyist, 1 or 2 clock management tiles are
probably enough.

PCIe resources are dedicated communication channels for PCI express. Normally used
to communicate with a computer motherboard. Not a low end function.

Gigabit tranceivers allow large amounts of data to enter and exit the chip quickly.
You won't normally find gigabit pins on entry level FPGA boards, they generally require
special RF connectors.

An analog to digital converter can be handy to have and may reduce parts count.

### Project Examples

To give you some feel for the number of features above.
I have an Apple 2 clone running on a Digilent Spartan 3 (XC3S1000) board. It uses 15%
of the available logic cells (17,280) and 85% of the available block RAM (432k).
It uses one clock management tile. No other resources are required.
XC3S1000 is at the higher end of the Spartan 3 family.

An Artix has plenty of grunt for hobbyists. My Hammond Organ synth project
is based around a Digilent Arty A7 board (XC7A35T).
It uses 61% of the available logic slices (33,280). Block RAM utilisation 
is 43% of 1,800k. It uses two clock management tiles and a single DSP slice.
Most of the space is taken up by a Microblaze processor and its support logic.

### On Board Features

Boards frequently come with switches, LEDs, displays and the like permanently
mounted on the board. Much of these are handy but not essential.

Items that are difficult to add externally include bulk memory (SRAM, SDRAM),
ethernet and HDMI ports.

Having a spare set of solder pads for a second crystal is nice to have.

### IO Pin Breakout

Something you want in any development board is to see plenty of pins broken out.
More pins means more flexability down the track. Hobbyists should look for connectors
that are easy to breadboard, i.e. DIL headers on 0.1" spacing. FMC and SMC connectors
are no hobbyist friendly.

Digilent boards have their own IO standard called PMod. This uses a 2x6 box header
with 0.1" spacing. Easy to connect to and there are 30+ PMods currently available.
Example modules include basic IO like slide switches, LEDs, ADC and DAC, displays
etc.

### Programming Method

Two questions in this category:
1. Does the board require an external programmer?
2. If on-board programming is available does it integrate with Vivado?

## Boards

### CLPD Boards

Very cheap but CPLDs are not FPGAs. CPLDs generally have 30-200 programmable cells.
FPGAs have 10,000+ programmable cells.

### Spartan 3/6 Boards

Spartan 3/6 are cheap. Should I buy one?

Pros - cheap, bang for buck. Verilog/VHDL run just fine without alteration in
most cases.

Cons - legacy devices not being used in new designs. Development software has
announced end of life. May require an external programmer ($$).

Digilent recommend moving to Artix based boards.

Curious hobbyists looking to save some money may find a bargain. Do your homework.

### Digilent CMod A7

USD 75/89 (XC7A15T/XC7A35T).

A budget option, very minimalist. Designed to mount on a breadboard, it has 48 
pins arranged in the standard 0.6" DIL pattern. Has 2 LEDs, 1 RGB LED, 2 pushbuttons
and 1 PMod connector. Programmer is on-board.

A good option to add an FPGA to your own board, i.e. as a daughter board.
As a standalone dev board I'd suggest the Arty A7.

### Digilent Arty A7

USD 99

An excellent board for the hobbyist market. Has an Artix XC7A35T, 256M SDRAM,
ethernet, programmer, buttns, slide switches and LEDs. Not as much as the
Basys 3, but enough. IO is 4xPMods plus space for a small Arduino shield.

This is the board I used for the Hammond organ project.

NB. board IO voltage is 3V3, many shields may not work.

### Digilent Basys 3

USD 149 (academic pricing available).

Nice board at a fair price, better if you qualify for academic pricing.
Based around the Artix XC7A35T, the board has *lots* of 
switches, LEDs, a 4 digit, seven segment display, VGA and USB.
4 PMod sockets makes it easily expandable.
There is an on-board programmer that integrates with Vivado.

Unfortunately the board has no external SRAM/SDRAM or ethernet.

Aimed at the TAFE student market.

### Digilent Nexsys 4 DDR

USD 265 (academic pricing available).

Big brother to the Basys 3. Has an Artix XC7A100T, 128Mb DDR2 RAM, ethernet etc.
More of everything. Target market is electrical engineering students.

### Digilent Nexsys Video

USD 479 (academic pricing available).

Top of the line Artix chip. Aimed at serious signal processing applications.
