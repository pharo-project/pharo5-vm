code editing
editCode: code inClass: class withSelector: selector
	| codeString |
	ranges := SHParserST80 new rangesIn: code classOrMetaClass: class workspace: nil  environment: nil.
	index := 1.
	codeIndex := 1.
	output := String new writeStream.
	codeString := code asString.
	self process: codeString.
	^output contents