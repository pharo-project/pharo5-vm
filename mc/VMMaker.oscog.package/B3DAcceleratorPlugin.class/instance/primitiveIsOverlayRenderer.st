primitives-renderer
primitiveIsOverlayRenderer
	| handle result |
	<export: true>
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFail].
	handle := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxIsOverlayRenderer(handle)' inSmalltalk:[false].
	interpreterProxy pop: 2. "args+rcvr"
	^interpreterProxy pushBool: result.