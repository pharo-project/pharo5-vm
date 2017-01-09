bytecode generators
genExtJumpIfTrue
	"243		11110011	i i i i i i i i	Pop and Jump 0n True i i i i i i i i (+ Extend B * 256, where Extend B >= 0)"
	| distance target |
	distance := byte1 + (extB << 8).
	self assert: distance = (self v4: (self generatorAt: byte0)
								LongForward: bytecodePC
								Branch: (extA ~= 0 ifTrue: [1] ifFalse: [0]) + (extB ~= 0 ifTrue: [1] ifFalse: [0])
								Distance: methodObj).
	extB := 0.
	numExtB := 0.
	target := distance + 2 + bytecodePC.
	^self genJumpIf: objectMemory trueObject to: target