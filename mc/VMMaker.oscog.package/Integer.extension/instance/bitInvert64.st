*VMMaker-bit manipulation
bitInvert64
	"Answer the 64-bit complement of the receiver."

	^self bitXor: 16rFFFFFFFFFFFFFFFF