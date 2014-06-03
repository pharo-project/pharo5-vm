primitives-renderer
primitiveCreateRendererFlags
	| flags h w y x result  |
	<export: true>
	interpreterProxy methodArgumentCount = 5
		ifFalse:[^interpreterProxy primitiveFail].
	h := interpreterProxy stackIntegerValue: 0.
	w := interpreterProxy stackIntegerValue: 1.
	y := interpreterProxy stackIntegerValue: 2.
	x := interpreterProxy stackIntegerValue: 3.
	flags := interpreterProxy stackIntegerValue: 4.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxCreateRendererFlags(x, y, w, h, flags)'.
	result < 0 ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: 6.
	^interpreterProxy pushInteger: result.