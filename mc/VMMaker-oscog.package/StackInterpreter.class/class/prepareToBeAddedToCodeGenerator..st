translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"Override to delete InterpreterPrimitives methods we override."
	aCodeGen removeVariable: 'cogit'.
	self selectors do:
		[:sel|
		 (superclass whichClassIncludesSelector: sel) ifNotNil:
			[aCodeGen removeMethodForSelector: sel]]