compile abstract instructions
genConvertCharacterToSmallIntegerInReg: reg
	"Convert the Character in reg to a SmallInteger, assuming
	 the Character's value is a valid character."
	"self assume: objectMemory smallIntegerTag = 1"
	self assert: (objectMemory characterTag = 2
				 and: [self numCharacterBits + 1 = self numSmallIntegerBits]).
	cogit LogicalShiftRightCq: 1 R: reg