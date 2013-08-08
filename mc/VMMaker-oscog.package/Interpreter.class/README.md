This class is a complete implementation of the Smalltalk-80 virtual machine, derived originally from the Blue Book specification but quite different in some areas.

It has been modernized with 32-bit pointers, better management of Contexts, and attention to variable use that allows the CCodeGenerator (qv) to keep, eg, the instruction pointer and stack pointer in registers as well as keeping most simple variables in a global array that seems to improve performance for most platforms.

In addition to SmallInteger arithmetic and Floats, it supports logic on 32-bit PositiveLargeIntegers, thus allowing it to simulate itself much more effectively than would otherwise be the case.

NOTE:  Here follows a list of things to be borne in mind when working on this code, or when making changes for the future.

1.  There are a number of things that should be done the next time we plan to release a copletely incompatible image format.  These include unifying the instanceSize field of the class format word -- see instantiateClass:indexableSize:, and unifying the bits of the method primitive index (if we decide we need more than 512, after all) -- see primitiveIndexOf:.  Also, contexts should be given a special format code (see next item).

2.  There are several fast checks for contexts (see isContextHeader: and isMethodContextHeader:) which will fail if the compact class indices of BlockContext or MethodContext change.  This is necessary because the oops may change during a compaction when the oops are being adjusted.  It's important to be aware of this when writing a new image using the systemTracer.  A better solution would be to reserve one of the format codes for Contexts only.

3.  We have made normal files tolerant to size and positions up to 32 bits.  This has not been done for async files, since they are still experimental.  The code in size, at: and at:put: should work with sizes and indices up to 31 bits, although I have not tested it (di 12/98); it might or might not work with 32-bit sizes.

4.  Note that 0 is used in a couple of places as an impossible oop.  This should be changed to a constant that really is impossible (or perhaps there is code somewhere that guarantees it --if so it should be put in this comment).  The places include the method cache and the at cache. 