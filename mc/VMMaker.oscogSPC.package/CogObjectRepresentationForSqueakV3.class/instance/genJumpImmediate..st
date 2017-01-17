compile abstract instructions
genJumpImmediate: aRegister
	^self genJumpSmallInteger: aRegister