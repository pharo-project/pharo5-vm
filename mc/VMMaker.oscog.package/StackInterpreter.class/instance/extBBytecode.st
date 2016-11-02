miscellaneous bytecodes
extBBytecode
	"225		11100001	sbbbbbbb	Extend B (Ext B = Ext B prev * 256 + Ext B)"
	| byte |
	byte := self fetchByte.
	self fetchNextBytecode.
	extB := (extB = 0 and: [byte > 127])
				ifTrue: [byte - 256]
				ifFalse: [(extB bitShift: 8) + byte]