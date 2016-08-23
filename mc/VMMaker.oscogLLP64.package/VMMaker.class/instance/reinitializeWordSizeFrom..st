initialize
reinitializeWordSizeFrom: aCCodeGenerator
	| wordSize |
	wordSize := aCCodeGenerator vmClass objectMemoryClass wordSize.
	optionsDictionary at: #BytesPerWord put: wordSize.
	is64BitVM := wordSize = 8