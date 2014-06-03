A CogCheckHeapMap is a simulation of the code in platforms/Cross/vm/sqHeapMap.c.  This is a map for leak checking that allocates 1 bit for every 4 bytes of address space.  It uses an array of pages to keep space overhead low, only allocating a page if that portion of the address space is used.  So the maximum overhead is address space size / (word size * bits per byte), or (2 raisedTo: 32) / (4 * 8) or 134,217,728 bytes.

Instance Variables
	pages:		<Array of: ByteArray>

pages
	- array of pages of bits, 1 bit per word of address space
