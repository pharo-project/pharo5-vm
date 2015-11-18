class initialization
initializeSpecificOpcodes: opcodeSymbolSequence in: initializeMethod
	"Declare as class variables, the opcodes in opcodeSymbolSequence.
	 Assign values to them from LastRTLOpcode on.  Undeclare any obsolete
	 class vars.  The assumption is that initializeMethod defines all class vars
	 in the class. This method should be used by subclasses wiching to declare
	 their own specific opcodes."
	| classVariablesDefinedInMethod |
	self assert: self ~~ CogAbstractInstruction.
	LastRTLCode ifNil:
		[CogRTLOpcodes initialize].
	classVariablesDefinedInMethod := (initializeMethod literals select: [:l| l isVariableBinding and: [classPool includesKey: l key]]) collect:
											[:ea| ea key].
	"Undeclare any class var not defined in opcodeSymbolSequence or by the method."
	(classPool keys reject: [:k| (opcodeSymbolSequence includes: k) or: [classVariablesDefinedInMethod includes: k]]) do:
		[:k|
		Undeclared declare: k from: classPool].
	"Declare opcodeSymbolSequence's elements from LastRTLCode on up."
	opcodeSymbolSequence withIndexDo:
		[:classVarName :value|
		self classPool
			declare: classVarName from: Undeclared;
			at: classVarName put: value + LastRTLCode - 1]