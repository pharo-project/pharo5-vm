primitives
primitiveGetFontList


	| strOop str strLength count |
	<export: true>
	<var: 'str' declareC: 'char *str'>

	strOop := interpreterProxy stackValue: 0.
	str := self asCString: strOop.
	interpreterProxy failed ifTrue: [^ nil].

	strLength := interpreterProxy stSizeOf: strOop.
	count := self cCode: 'unicodeGetFontList(str, strLength)'.

	interpreterProxy pop: 2
		thenPush: (interpreterProxy integerObjectOf: count).
	^ 0
