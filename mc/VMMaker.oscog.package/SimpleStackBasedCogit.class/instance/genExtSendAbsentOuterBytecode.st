bytecode generators
genExtSendAbsentOuterBytecode
	"254		 11111110	i i i i i j j j kkkkkkkk	Send To Absent Outer Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments at Depth kkkkkkkk "
	| litIndex nArgs depth |
	litIndex := (byte1 >> 3) + (extA << 5).
	extA := 0.
	nArgs := (byte1 bitAnd: 7) + (extB << 3).
	extB := 0.
	numExtB := 0.
	depth := byte2.
	^self genSendAbsentOuter: litIndex numArgs: nArgs depth: depth
