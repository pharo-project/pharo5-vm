bytecode generators
extABytecode
	"224		11100000	aaaaaaaa	Extend A (Ext A = Ext A prev * 256 + Ext A)"
	extA := (extA bitShift: 8) + byte1.
	^0