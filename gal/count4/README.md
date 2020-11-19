# GAL Counter Example

Created November 2020

## Project Description

A 4 bit binary up counter implemented using a GAL22V10.

Source file is count4.pld.

File count4.lst is the listing. It shows the source file after all the macros
have been expanded i.e. post pre-processor. This is the actual CUPL compiler
input.

File count4.doc describes how the compiler interpreted the input. It
shows the per output logic equations derived from the higher level code
(product terms). It also shows the fuse plot i.e. the way the physical
fuses will get programmed.

The final file in the sequence is count4.jed. This file is passed to the
device programmer.

There are other output files but these are the most useful.
