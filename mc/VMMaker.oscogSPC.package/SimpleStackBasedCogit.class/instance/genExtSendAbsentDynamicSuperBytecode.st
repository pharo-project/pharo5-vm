bytecode generators
genExtSendAbsentDynamicSuperBytecode
	"241		11110001	i i i i i j j j	Send To Absent Dynamic Superclass Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	| litIndex nArgs |
	litIndex := (byte1 >> 3) + (extA << 5).
	extA := 0.
	nArgs := (byte1 bitAnd: 7) + (extB << 3).
	extB := 0.
	numExtB := 0.
	^self genSendAbsentDynamicSuper: litIndex numArgs: nArgs