bytecode generators
genExtSendSuperBytecode
	"239		11101111	i i i i i j j j	Send To Superclass Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	| isDirected litIndex nArgs |
	(isDirected := extB >= 64) ifTrue:
		[extB := extB bitAnd: 63].
	litIndex := (byte1 >> 3) + (extA << 5).
	extA := 0.
	nArgs := (byte1 bitAnd: 7) + (extB << 3).
	extB := 0.
	^isDirected
		ifTrue: [self genSendDirectedSuper: litIndex numArgs: nArgs]
		ifFalse: [self genSendSuper: litIndex numArgs: nArgs]