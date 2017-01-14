primitives-textures
primitiveDestroyTexture
	| handle result renderer |
	<export: true>
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	handle := interpreterProxy stackIntegerValue: 0.
	renderer := interpreterProxy stackIntegerValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxDestroyTexture(renderer, handle)' inSmalltalk:[false].
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 2. "pop arg; return rcvr"