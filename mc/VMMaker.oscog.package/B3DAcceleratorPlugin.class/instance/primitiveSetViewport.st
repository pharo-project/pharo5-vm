primitives-renderer
primitiveSetViewport
	| h w y x result handle |
	<export: true>
	interpreterProxy methodArgumentCount = 5
		ifFalse:[^interpreterProxy primitiveFail].
	h := interpreterProxy stackIntegerValue: 0.
	w := interpreterProxy stackIntegerValue: 1.
	y := interpreterProxy stackIntegerValue: 2.
	x := interpreterProxy stackIntegerValue: 3.
	handle := interpreterProxy stackIntegerValue: 4.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxSetViewport(handle, x, y, w, h)'.
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 5. "pop args; return rcvr"