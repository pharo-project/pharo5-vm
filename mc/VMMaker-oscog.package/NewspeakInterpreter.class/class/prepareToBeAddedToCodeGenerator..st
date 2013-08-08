translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"Override to avoid repeating ObjectMemory's preparations
	 and to delete ObjectMemory methods we override."
	self selectors do:
		[:sel|
		 (superclass whichClassIncludesSelector: sel) ifNotNil:
			[aCodeGen removeMethodForSelector: sel]]