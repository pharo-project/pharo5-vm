compile abstract instructions
genConvertCharacterToSmallIntegerInReg: reg
	"Convert the SmallInteger in reg to a Character, assuming
	 the SmallInteger's value is a valid character."
	cogit SubCq: objectMemory characterTag - objectMemory smallIntegerTag R: reg