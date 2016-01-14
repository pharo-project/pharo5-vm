compile abstract instructions
genConvertCharacterToSmallIntegerInReg: reg
	"Convert the Character in reg to a SmallInteger, assuming
	 the Character's value is a valid character."
	cogit SubCq: objectMemory characterTag - objectMemory smallIntegerTag R: reg