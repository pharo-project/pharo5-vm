primitives-textures
primitiveTextureByteSex
	| handle result renderer |
	<export: true>
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	handle := interpreterProxy stackIntegerValue: 0.
	renderer := interpreterProxy stackIntegerValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxTextureByteSex(renderer, handle)' inSmalltalk:[-1].
	result < 0 ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: 3.
	^interpreterProxy pushBool: result.