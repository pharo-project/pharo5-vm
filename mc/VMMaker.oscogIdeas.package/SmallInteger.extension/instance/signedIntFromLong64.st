*VMMaker-interpreter simulator
signedIntFromLong64
	"Self is a signed or unsigned 64-bit integer.
	 Currently SmallIntegers are either 31-bit (in the 32-bit implementation) or 61-bit
	 (in the 64-bit implementation) so save some time by overriding in the subclass."
	^self