primitives-textures
primitiveAllocateTexture
	| h w d result renderer |
	<export: true>
	interpreterProxy methodArgumentCount = 4
		ifFalse:[^interpreterProxy primitiveFail].
	h := interpreterProxy stackIntegerValue: 0.
	w := interpreterProxy stackIntegerValue: 1.
	d := interpreterProxy stackIntegerValue: 2.
	renderer := interpreterProxy stackIntegerValue: 3.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxAllocateTexture(renderer, w, h, d)' inSmalltalk:[-1].
	result = -1 ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: 5. "args+rcvr"
	^interpreterProxy pushInteger: result.