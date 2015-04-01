initialization
simulatedAddressFor: anObject
	"Answer a simulated address for a block or a symbol.  This is an address that
	 can be called, read or written by generated machine code, and will be mapped
	 into a Smalltalk message send or block evaluation.

	 N.B. These addresses are at the top end of the bottom half of the address space
	 so that they don't have the sign bit set and so will not look like negative numbers,
	 unless they're the short-cut routines on ARM, where we want to use a bl, not a blx."
	<doNotGenerate>
	^simulatedAddresses
		at: anObject
		ifAbsentPut: [self fakeAddressFor: anObject index: simulatedAddresses size]