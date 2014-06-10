utilities
compileToTMethodSelector: selector in: aClass
	"Compile a method to a TMethod"

	^(Compiler new
		parse: (aClass sourceCodeAt: selector)
		in: aClass
		notifying: nil)
			asTranslationMethodOfClass: self translationMethodClass