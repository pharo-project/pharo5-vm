translation
prepareToBeAddedToCodeGenerator: aCCodeGenerator
	"Override to avoid repeating Cogit's preparations and remove the methods we override."
	self selectors do:
		[:sel|
		 (Cogit includesSelector: sel) ifTrue:
			[aCCodeGenerator removeMethodForSelector: sel]]