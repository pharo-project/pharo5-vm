memory access
long32At: byteAddress

	"Return the 32-bit word at byteAddress which must be 0 mod 4."
	| lowBits long |
	lowBits := byteAddress bitAnd: 4.
	long := self longAt: byteAddress - lowBits.
	^ lowBits = 4
		ifTrue: [ long bitShift: -32 ]
		ifFalse: [ long bitAnd: 16rFFFFFFFF ].
