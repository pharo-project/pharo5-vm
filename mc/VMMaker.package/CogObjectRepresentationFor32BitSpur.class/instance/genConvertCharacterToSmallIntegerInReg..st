compile abstract instructions
genConvertCharacterToSmallIntegerInReg: reg
	"Convert the SmallInteger in reg to a Character, assuming
	 the SmallInteger's value is a valid character."
	"self assume: objectMemory smallIntegerTag = 1"
	self assert: (objectMemory characterTag = 2
				 and: [self numCharacterBits + 1 = self numSmallIntegerBits]).
	cogit LogicalShiftRightCq: 1 R: reg