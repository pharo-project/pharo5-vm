compile abstract instructions
genConvertSmallIntegerToCharacterInReg: reg
	"Convert the SmallInteger in reg to a Character, assuming
	 the SmallInteger's value is a valid character."
	cogit AddCq: objectMemory characterTag - objectMemory smallIntegerTag R: reg