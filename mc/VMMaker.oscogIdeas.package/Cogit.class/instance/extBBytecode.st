bytecode generators
extBBytecode
	"225		11100001	sbbbbbbb	Extend B (Ext B = Ext B prev * 256 + Ext B)"
	extB := (numExtB = 0 and: [byte1 > 127])
				ifTrue: [byte1 - 256]
				ifFalse: [(extB bitShift: 8) + byte1].
	numExtB := numExtB + 1.
	^0