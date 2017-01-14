bytecode generators
genShortUnconditionalJump
	| distance target |
	distance := self v3: (self generatorAt: byte0)
					ShortForward: bytecodePC
					Branch: 0
					Distance: methodObj.
	target := distance + 1 + bytecodePC.
	^self genJumpTo: target