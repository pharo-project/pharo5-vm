translation
prepareToBeAddedToCodeGenerator: aCCodeGenerator
	"Override to avoid repeating SimpleStackBasedCogit's preparations and remove the methods we override."
	self selectors do:
		[:sel|
		 (superclass whichClassIncludesSelector: sel) ifNotNil:
			[aCCodeGenerator removeMethodForSelector: sel]]