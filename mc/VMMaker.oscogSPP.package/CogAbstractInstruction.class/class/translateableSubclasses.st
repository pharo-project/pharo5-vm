translation
translateableSubclasses
	"CogAbstractInstruction translateableSubclasses"
	^self subclasses select:
		[:compilerClass|
		 compilerClass wordSize = Cogit objectMemoryClass wordSize
		 and: [compilerClass identifyingPredefinedMacros notNil]]