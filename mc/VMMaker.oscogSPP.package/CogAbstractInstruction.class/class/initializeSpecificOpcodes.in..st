class initialization
initializeSpecificOpcodes: opcodeSymbolSequence in: initializeMethod
	"Declare as class variables, the opcodes in opcodeSymbolSequence.
	 Assign values to them from LastRTLOpcode on.  Undeclare any obsolete
	 class vars.  The assumption is that initializeMethod defines all class vars
	 in the class. This method should be used by subclasses wishing to declare
	 their own specific opcodes."
	| pool classVariablesDefinedInMethod |
	self assert: self ~~ CogAbstractInstruction.
	pool := initializeMethod methodClass classPool.
	LastRTLCode ifNil:
		[CogRTLOpcodes initialize].
	classVariablesDefinedInMethod := (initializeMethod literals select: [:l| l isVariableBinding and: [pool includesKey: l key]]) collect:
											[:ea| ea key].
	"Undeclare any class var not defined in opcodeSymbolSequence or by the method."
	(pool keys reject: [:k| (opcodeSymbolSequence includes: k) or: [classVariablesDefinedInMethod includes: k]]) do:
		[:k|
		Undeclared declare: k from: pool].
	"Declare opcodeSymbolSequence's elements from LastRTLCode on up."
	opcodeSymbolSequence withIndexDo:
		[:classVarName :value|
		pool
			declare: classVarName from: Undeclared;
			at: classVarName put: value + LastRTLCode - 1]