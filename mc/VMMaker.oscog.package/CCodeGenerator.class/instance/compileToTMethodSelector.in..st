utilities
compileToTMethodSelector: selector in: aClass
	"Compile a method to a TMethod"
	| implementingClass |
	implementingClass := aClass.
	^(Compiler new
		parse: ([aClass sourceCodeAt: selector]
					on: KeyNotFound
					do: [:ex| "Quick hack for simulating Pharo images..."
						(PharoVM and: [aClass == String class and: [selector == #findSubstringViaPrimitive:in:startingAt:matchTable:]]) ifFalse:
							[ex pass].
						(implementingClass :=  ByteString) sourceCodeAt: #findSubstring:in:startingAt:matchTable:])
		in: implementingClass
		notifying: nil)
			asTranslationMethodOfClass: self translationMethodClass