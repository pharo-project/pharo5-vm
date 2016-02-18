in-line cacheing
indexForSelector: selector in: cogMethod at: mcpc
	"Answer the value to put in an inline-cache that is being loaded with the selector.
	 Usually this is simply the selector, but in 64-bits the cache is only 32-bits wide
	 and so the cache is loaded with the index of the selector."
	<var: #cogMethod type: #'CogMethod *'>
	<inline: false>
	| methodOop |
	self assert: (mcpc asUnsignedInteger > cogMethod asUnsignedInteger
				and: [mcpc < (cogMethod asUnsignedInteger + cogMethod blockSize)]).
	"First search the special selectors; there are only 32 of them so this shouldn't take too long.
	 We could short-circuit this by keeping a hint bit in the target method, or by maintaining the
	 maximum range of selector oops in specialSelectors since they're likely to cluster."
	0 to: NumSpecialSelectors - 1 do:
		[:i|
		selector = (coInterpreter specialSelector: i) ifTrue:
			[^-1 - i]].
	methodOop := cogMethod methodObject.
	"Then search the method's literal frame... open code fetchPointer:ofObject: for speed..."
	LiteralStart to: (objectMemory literalCountOfMethodHeader: cogMethod methodHeader) do:
		[:i|
		(objectMemory longAt: i * objectMemory bytesPerOop + objectMemory baseHeaderSize + methodOop) = selector ifTrue:
			[self assert: selector = (coInterpreter literal: i - 1 ofMethod: methodOop).
			 ^i - 1]].

	self error: 'could not find selector in method when unlinking send site'.
	^0