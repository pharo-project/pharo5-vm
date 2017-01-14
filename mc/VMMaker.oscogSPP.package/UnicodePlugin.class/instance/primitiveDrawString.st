primitives
primitiveDrawString

	| utf8Oop utf8 w h bitmapOop bitmapPtr utf8Length result |
	<export: true>
	<var: 'utf8' declareC: 'char *utf8'>
	<var: 'bitmapPtr' declareC: 'void *bitmapPtr'>

	utf8Oop := interpreterProxy stackValue: 3.
	utf8 := self asCString: utf8Oop.
	w := interpreterProxy stackIntegerValue: 2.
	h := interpreterProxy stackIntegerValue: 1.
	bitmapOop := interpreterProxy stackValue: 0.
	bitmapPtr := self cWordsPtr: bitmapOop minSize: w * h.
	interpreterProxy failed ifTrue: [^ nil].

	utf8Length := interpreterProxy stSizeOf: utf8Oop.
	self cCode: 'unicodeDrawString(utf8, utf8Length, &w, &h, bitmapPtr)'.

	result := interpreterProxy makePointwithxValue: w yValue: h.
	interpreterProxy pop: 5 thenPush: result.
	^ 0
