primitives-renderer
primitiveCreateRenderer
	"NOTE: This primitive is obsolete but should be supported for older images"
	| h w y x result allowHardware allowSoftware |
	<export: true>
	interpreterProxy methodArgumentCount = 6
		ifFalse:[^interpreterProxy primitiveFail].
	h := interpreterProxy stackIntegerValue: 0.
	w := interpreterProxy stackIntegerValue: 1.
	y := interpreterProxy stackIntegerValue: 2.
	x := interpreterProxy stackIntegerValue: 3.
	allowHardware := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 4).
	allowSoftware := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 5).
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxCreateRenderer(allowSoftware, allowHardware, x, y, w, h)'.
	result < 0 ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: 7.
	^interpreterProxy pushInteger: result.