primitives
primitiveGetXRanges

	| utf8Oop utf8 resultOop resultPtr utf8Length count resultLength |
	<export: true>
	<var: 'utf8' declareC: 'char *utf8'>
	<var: 'resultPtr' declareC: 'int *resultPtr'>

	utf8Oop := interpreterProxy stackValue: 1.
	utf8 := self asCString: utf8Oop.

	resultOop := interpreterProxy stackValue: 0.
	resultPtr := self cWordsPtr: resultOop minSize: 0.
	interpreterProxy failed ifTrue: [^ nil].

	utf8Length := interpreterProxy stSizeOf: utf8Oop.
	resultLength := interpreterProxy stSizeOf: resultOop.
	count := self cCode: 'unicodeGetXRanges(utf8, utf8Length, resultPtr, resultLength)'.

	interpreterProxy pop: 3 thenPush: (interpreterProxy integerObjectOf: count).
	^ 0
