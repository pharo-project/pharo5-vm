code editing
editCode: code inClass: class withSelector: selector
	| codeString |
	ranges := SHParserST80 new rangesIn: code classOrMetaClass: class workspace: nil  environment: nil.
	index := 1.
	codeIndex := 1.
	output := String new writeStream.
	codeString := code asString.
	self process: codeString while: [:ign| true].
	"(StringHolder new textContents:
		(TextDiffBuilder buildDisplayPatchFrom: code to: output contents))
			openLabel: class name , '>>', selector."
	^output contents