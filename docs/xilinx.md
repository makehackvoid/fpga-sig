# Xilinx
Created: 22 May 2018

Updated: 22 May 2018

## Overview

Xilinx designed the original FPGAs in 1984. They offer a *lot* of
products, in various price ranges. In 2018, the current 'state of the art'
is Xilinx 7 series. These are arranged in four families, lowest cost first
down to highest performance:

1. Spartan7
2. Artix7
3. Kintex7
4. Virtex7

Spartan7 and Artix7 devices are in the hobbyist price range. The main difference
between the two device families is that some Artix devices have high speed serial
tranceivers (~6Gbit/s) and PCIe support. Spartan does not support either. See
Xilinx document DS180 for details.

Kintex and Virtex are high performance families and beyond the hobbyist budget.

The Zynq family is a hybrid, also known as system on chip (SoC). Zynq devices contain
an ARM cortex processor plus an FPGA. Embedded Linux with a custom co-processor.

Spartan 3, Spartan 6, and Virtex 4/5 families are legacy. Still being sold but
no longer being developed.

## Design Software - Vivado

Vivado is the latest Xilinx IDE. It supports all 7 series families, it only supports
7 series. Hobbyists can make use of the free WEBPACK licence. Vivado 2016.4
and later suport all Spartan and Artix devices for free. Most Kintex and all Virtex devices require a software licence fee.

## Design Software - ISE

ISE supports legacy devices such as Spartan3/6 and CPLDs. A very mature and capable
product that has reached the end of its development life. Last release was 14.7.
Xilinx will not be releasing any further updates.

## Xilinx Documentation Releases

Xilinx documentation is commonly identified by a short code formatted AANNN<N>.
Where AA represents two letters and NNN<N> is three or four digits. For example
DS180, UG973.

Documentation is frequently updated, sometimes several times in a single year.
Documentation releases often co-incide with Vivado releases, user guides (UG)
in particular. Page footers often contain values like 'UG973 (v2016.4)',
clearly marking the document id and version.

A stand-alone documentation management application gets installed along with Vivado.
It provides a convenient mechanim to access the latest documentation versions.

Be wary of Google search results. Google indexes *lots* of Xilinx PDFs held in
a multitude of servers. Most of these servers have nothing to do with Xilinx.
Universities, and university students in particular, like to squirrel away their
own cached version in publicly accessible websites.
