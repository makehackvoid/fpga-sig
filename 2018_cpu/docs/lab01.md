# Lab 01 - Software Installation
Created: 29 May 2018

Updated: 29 May 2018

Vivado installation involves a very large download, the 'everything' download
comes in at 20G bytes. The workshop install can be much smaller, ~8G. Unless you have a
high speed internet connection you will want to run this overnight.

You will need to create an account at xilinx.com. This is unavoidable. FPGA design
software is subject to US export restrictions. You must agree to not use Vivado for
nefarious purposes or supply it to a 3rd party. I imagine Intel and Lattice tooling
requires the same.

A high spec machine is desirable as an FPGA workstation. I run mine in a Win 7/8
virtual machine hosted in MacOS (Fusion). It has 4G RAM and half of an i5 processor
available. I find this is ok for simple tasks but bogs down a little with more
advanced designs. By 'bogs down' I mean it takes ~20 mins to complete a
synthesis/implement cycle.

I have an old IBM rack mount server running Ubuntu 16.04. Vivado installs and runs
ok but is a little slow, even with the basics.

## Create Account

Navigate to http://www.xilinx.com and click on the person head icon in the top centre
of the screen. Enter your personal details and a password. This may involve some to and fro with emails etc. My account is several years old and I skipped this bit.

## Download

The downloads section is found nested under Support > Downloads & Licencing.
You should be able to see several links related to "Vivado design Suite - HLx 
Editions".

The easiest option is to grab the web install client for either Windows or Linux.
Windows 7/8/10 is supported as are several Linux flavours - SUSE, CentOS, RHEL
and Ubuntu. Download and run the web client, you will need to provide your
Xilinx login details, then agree to the EULA stuff. You need to select the
"Vivado HL WebPACK" edition.

NB. Vivado WebPACK provides free support for Spartan-7 and Artix-7 family devices.

### Feature Set

You can customise your installation by selecting from the features below:

1. Design Tools - Use default selections
1. Devices - May want to customise but can safely leave as defaults
    1. Production Devices
        1. SoCs - Can reduce download size by unchecking the Zynq device support
        1. 7 Series - Can reduce download size by unchecking Spartan and Kintex. Workshop will target Artix. Xilinx example projects target Kintex, leave this checked if you're planning on doing any of those
        1. Ultrascale - Uncheck, not required
        1. Ultrascale+ - Uncheck, not required
    1. Engineering Samples - Leave at default (unchecked)
1. Installation Options - Use default selections

The next screen allows you to customize the install location, probably best to leave 
these settings at their defaults.

Start the download and come back the next day (seriously). If you're on Windows an
OS restart is probably called for.

## Licencing

Good news! It looks like Xilinx have started including a WebPACK licence file in
the software download. With older releases you had to mess about generating, 
downloading and installing a licence file to get this stuff to work.
