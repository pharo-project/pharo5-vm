primitives
primitiveClipboardSize

	| count |
	<export: true>

	count := self cCode: 'unicodeClipboardSize()'.

	interpreterProxy pop: 1
		thenPush: (interpreterProxy integerObjectOf: count).
	^ 0
