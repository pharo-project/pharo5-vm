compile abstract instructions
genConvertSmallIntegerToCharacterInReg: reg
	"Convert the SmallInteger in reg to a Character, assuming
	 the SmallInteger's value is a valid character."
	self assert: (objectMemory characterTag = 2 and: [objectMemory smallIntegerTag = 1]).
	cogit AddCq: 1 R: reg