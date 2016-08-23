testing
conditionIsNotNever: instr
	"test for the NV condition code; this isn't allowed as an actual condition and is used to encdoe many of the newer instructions"
	^instr >> 28 < 16rF 