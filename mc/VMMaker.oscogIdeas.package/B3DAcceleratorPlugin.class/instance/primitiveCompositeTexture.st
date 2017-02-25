primitives-textures
primitiveCompositeTexture
	| result translucent y x w h texHandle rendererHandle |
	<export: true>
	interpreterProxy methodArgumentCount = 7
		ifFalse:[^interpreterProxy primitiveFail].
	translucent := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	h := interpreterProxy stackIntegerValue: 1.
	w := interpreterProxy stackIntegerValue: 2.
	y := interpreterProxy stackIntegerValue: 3.
	x := interpreterProxy stackIntegerValue: 4.
	texHandle := interpreterProxy stackIntegerValue: 5.
	rendererHandle := interpreterProxy stackIntegerValue: 6.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxCompositeTexture(rendererHandle, texHandle, x, y, w, h, translucent)' inSmalltalk:[false].
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 7. "args"
