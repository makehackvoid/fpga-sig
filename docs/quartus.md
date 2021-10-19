# Quartus Installation

Created: 19 Oct 2021

Stephen Davies

## Overview

Just a quick note to document some 'gotchas' around installing
Intel's Quartus Prime Lite v20.1.1 software on Linux. A friend was
attempting to install it on Fedora 34 and was having troubles with
missing libraries. I managed to find these
[Debian Instructions](https://github.com/Jefferson-Lopes/quartus-installation).

According to the Quartus Prime install notes, Red Hat 7 with KDE is 
Linux platform of choice. I can confirm that the software installs 
with CentOS 7 + KDE plasma desktop. Quartus Prime is BIG, a 40Gb
disk minimum is suggested. 

Once the OS is installed you need the following 32 bit libraries:

~~~bash
sudo yum install libXft*i686 libXext*i686 ncurses-libs*i686 bzip2*i686
~~~

Once the 32 libraries are installed follow the Quartus Prime
installation notes. The software should install and run without issue.
