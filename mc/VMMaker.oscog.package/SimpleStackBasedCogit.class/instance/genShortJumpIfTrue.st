bytecode generators
genShortJumpIfTrue
	| distance target |
	distance := self v3: (self generatorAt: byte0)
					ShortForward: bytecodePC
					Branch: 0
					Distance: methodObj.
	target := distance + 1 + bytecodePC.
	^self genJumpIf: objectMemory trueObject to: target