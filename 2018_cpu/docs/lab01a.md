# Lab 01a - Local Repository Installation (optional)
Created: 31 May 2018

Updated: 31 May 2018

For this workshop there are a bunch of files you are going to need to get started.
They will be made available on a flash drive during the workshop so you can copy them.

As an alternative you can simply check them out from GitHub. The choice is yours.
If you decide to go down the GitHub route then you may need to install the Git
client software.

## Git 

### Windows/Linux Client

Browse to https://git-scm.com/downloads and follow the download and install
instructions there.

### OSX/MacOS

If you're using OSX/MacOS and XCode then Git is probably 
installed. Try running `git` in a Terminal window.

Otherwise follow the steps for Windows/Linux above.

## Local Repository Setup

Once Git client software is installed you need to:
  1. Figure out where to put it
  1. Clone the repository

It doesn't really matter exactly where you put this, you're not expected to
be making commits, just using the files to read and copy. On Windows I created
a temp directory, `C:\Temp`.

Your mileage may vary...

    C:\Users\sjdavies>mkdir \Temp
    C:\Users\sjdavies>cd \Temp
    C:\Temp>git clone https://github.com/makehackvoid/fpga-sig.git
    Cloning into 'fpga-sig'...
    remote: Counting objects: 65, done.
    remote: Compressing objects: 100% (41/41), done.
    remote: Total 65 (delta 19), reused 57 (delta 11), pack-reused 0
    Unpacking objects: 100% (65/65), done.

    C:\Temp>cd fpga-sig
    C:\Temp\fpga-sig>

If there are a bunch of directories and files nested under *fpga-sig* then you're
good to go.

## Late Breaking Changes

The GitHub repository is very much a work in progress. If you decide to clone the
repository either before or during the workshop be warned that it is subject to change.

You can synchronise your local repository with GitHub by:

    C:\Temp\fpga-sig>git fetch
    ...

    C:\Temp\fpga-sig>git pull
    ...
