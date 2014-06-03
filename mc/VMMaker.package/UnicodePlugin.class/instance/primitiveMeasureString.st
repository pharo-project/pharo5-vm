primitives
primitiveMeasureString

	| utf8Oop utf8 utf8Length w h result |
	<export: true>
	<var: 'utf8' declareC: 'char *utf8'>

	utf8Oop := interpreterProxy stackValue: 0.
	utf8 := self asCString: utf8Oop.
	interpreterProxy failed ifTrue: [^ nil].

	w := h := 0.
	utf8Length := interpreterProxy stSizeOf: utf8Oop.
	self cCode: 'unicodeMeasureString(utf8, utf8Length, &w, &h)'.

	result := interpreterProxy makePointwithxValue: w yValue: h.
	interpreterProxy pop: 2 thenPush: result.
	^ 0
