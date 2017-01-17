bytecode generators
genLongJumpIfTrue
	| distance target |
	distance := self v3: (self generatorAt: byte0) LongForward: bytecodePC Branch: 0 Distance: methodObj.
	target := distance + 2 + bytecodePC.
	^self genJumpIf: objectMemory trueObject to: target