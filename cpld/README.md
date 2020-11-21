# CPLD
Created: 6 June 2018

Author: Stephen Davies

## Overview

Some people have made CPLD related comments in the FPGA workshop discussion thread.
I have a couple CPLD breakout boards that I purchased some time back for another
project. Until now I haven't attempted to program them myself.

Thought other people might find this useful.

## What is a CPLD?

According to Wikipedia *"A complex programmable logic device (CPLD) is a programmable logic device with complexity between that of PALs and FPGAs, and architectural features of both"*.

CPLDs tend to be 'smaller' than FPGAs, providing much less programmable logic and
much less in the way of I/O pins.

Another area where they differ is volatility. CPLDs are non-volatile. They generally
incorporate some type of erasable storage, e.g. flash, inside the device. FPGAs are
based around static RAM cells, i.e. they use volatile storage.
An FPGA normally requires an external flash device to store it configuration. The
configuration must be loaded at power up and can result in a noticeable delay.

## CPLD Applications

A traditional role for CPLDs has been as 'glue logic', replacing multiple discrete
logic chips with a single CPLD.

Another application for CPLDs is as dedicated state machines (controllers), although
the availaility of cheap microcontrollers has had an impact.
