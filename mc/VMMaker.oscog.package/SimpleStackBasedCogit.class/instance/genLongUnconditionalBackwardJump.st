bytecode generators
genLongUnconditionalBackwardJump
	| distance |
	distance := self v3: (self generatorAt: byte0)
					Long: bytecodePC
					Branch: 0
					Distance: methodObj.
	self assert: distance < 0.
	^self genJumpBackTo: distance + 2 + bytecodePC