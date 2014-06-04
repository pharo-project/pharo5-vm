bytecode generators
genLongUnconditionalForwardJump
	| distance targetpc |
	distance := self v3: (self generatorAt: byte0)
					Long: bytecodePC
					Branch: 0
					Distance: methodObj.
	self assert: distance >= 0.
	targetpc := distance + 2 + bytecodePC.
	^self genJumpTo: targetpc