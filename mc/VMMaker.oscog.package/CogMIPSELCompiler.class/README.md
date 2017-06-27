Implemenation for 32-bit, little-endian MIPS running with the OABI (Debian port name 'mipsel').

Status: incomplete, no work planned

In December 2015, this implementation was complete enough to run the Newspeak test suite under the simulator. The compiled VM, however, failed at startup. The author suspects that some variables are lacking correct type annotations, being translated by Slang as unsigned when they should be signed or vice versa, causing some shift or comparison to have the wrong signness in C, but it may well be some other discrepancy between the behavior of Slang code when run in Smalltalk and when translated to C.

This implementation also does not provide instructions for working with floating point numbers, instead falling back to the interpreter's implementation for all floating point operations.
