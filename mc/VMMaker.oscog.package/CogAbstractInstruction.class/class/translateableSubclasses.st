translation
translateableSubclasses
	"CogAbstractInstruction translateableSubclasses"
	^self subclasses select: [:compilerClass| compilerClass identifyingPredefinedMacros notNil]