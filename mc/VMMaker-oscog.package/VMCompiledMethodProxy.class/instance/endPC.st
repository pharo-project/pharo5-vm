accessing
endPC
	"Answer the index of the last bytecode."
	^(coInterpreter cogit endPCOf: oop) + 1