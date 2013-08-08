This class describes a 32-bit direct-pointer object memory for Smalltalk.  The model is very simple in principle:  a pointer is either a SmallInteger or a 32-bit direct object pointer.

SmallIntegers are tagged with a low-order bit equal to 1, and an immediate 31-bit 2s-complement signed value in the rest of the word.

All object pointers point to a header, which may be followed by a number of data fields.  This object memory achieves considerable compactness by using a variable header size (the one complexity of the design).  The format of the 0th header word is as follows:

	3 bits	reserved for gc (mark, root, unused)
	12 bits	object hash (for HashSets)
	5 bits	compact class index
	4 bits	object format
	6 bits	object size in 32-bit words
	2 bits	header type (0: 3-word, 1: 2-word, 2: forbidden, 3: 1-word)

If a class is in the compact class table, then this is the only header information needed.  If it is not, then it will have another header word at offset -4 bytes with its class in the high 30 bits, and the header type repeated in its low 2 bits.  It the objects size is greater than 255 bytes, then it will have yet another header word at offset -8 bytes with its full word size in the high 30 bits and its header type repeated in the low two bits.

The object format field provides the remaining information as given in the formatOf: method (including isPointers, isVariable, isBytes, and the low 2 size bits of byte-sized objects).

This implementation includes incremental (2-generation) and full garbage collection, each with compaction and rectification of direct pointers.  It also supports a bulk-become (exchange object identity) feature that allows many objects to be becomed at once, as when all instances of a class must be grown or shrunk.

There is now a simple 64-bit version of the object memory.  It is the simplest possible change that could work.  It merely sign-extends all integer oops, and extends all object headers and oops by adding 32 zeroes in the high bits.  The format of the base header word is changed in one minor, not especially elegant, way.  Consider the old 32-bit header:
	ggghhhhhhhhhhhhcccccffffsssssstt
The 64-bit header is almost identical, except that the size field (now being in units of 8 bytes, has a zero in its low-order bit.  At the same time, the byte-size residue bits for byte objects, which are in the low order bits of formats 8-11 and 12-15, are now in need of another bit of residue.  So, the change is as follows:
	ggghhhhhhhhhhhhcccccffffsssssrtt
where bit r supplies the 4's bit of the byte size residue for byte objects.  Oh, yes, this is also needed now for 'variableWord' objects, since their size in 32-bit words requires a low-order bit.

See the comment in formatOf: for the change allowing for 64-bit wide bitmaps, now dubbed 'variableLong'.