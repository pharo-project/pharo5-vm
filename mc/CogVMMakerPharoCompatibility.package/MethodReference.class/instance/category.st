accessing
category
	"Answers the class category (cached for reuse via MC and other tools)"
	^ category ifNil: [category := self actualClass organization categoryOfElement: methodSymbol]