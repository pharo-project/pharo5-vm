translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"Remove the methods of CogAbstractInstruction we override."
	self selectors do:
		[:sel|
		 (superclass includesSelector: sel) ifTrue:
			[aCodeGen removeMethodForSelector: sel]].