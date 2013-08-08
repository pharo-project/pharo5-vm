translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"Remove the methods of ThreadedFFIPlugin any concrete subclass overrides."
	self class ~~ thisContext methodClass ifTrue:
		[self selectors do:
			[:sel|
			 (superclass includesSelector: sel) ifTrue:
				[aCodeGen removeMethodForSelector: sel]]]