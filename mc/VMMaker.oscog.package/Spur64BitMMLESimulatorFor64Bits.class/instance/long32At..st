memory access
long32At: byteAddress
	"Answer the 32-bit word at byteAddress which must be a multiple of four."
	| lowBits long |
	lowBits := byteAddress bitAnd: 4.
	long := self long64At: byteAddress - lowBits.
	^lowBits = 4
		ifTrue: [long bitShift: -32]
		ifFalse: [long bitAnd: 16rFFFFFFFF]