translated primitives
methodForTranslatedPrimitiveTuple: tuple
	| class |
	class := Smalltalk classNamed: tuple first.
	^class
		compiledMethodAt: tuple last
		ifAbsent:
			[class class
				compiledMethodAt: tuple last
				ifAbsent: [tuple = #(String findSubstringViaPrimitive:in:startingAt:matchTable:) ifTrue:
							[ByteString compiledMethodAt: #findSubstring:in:startingAt:matchTable:]]]