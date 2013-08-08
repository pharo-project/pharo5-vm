primitives-textures
primitiveTextureUpload
	| h w d result form bits ppw bitsPtr handle renderer |
	<export: true>
	<var: #bitsPtr type: 'void*'>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	form := interpreterProxy stackValue: 0.
	((interpreterProxy isPointers: form) and:[(interpreterProxy slotSizeOf: form) >= 4])
		ifFalse:[^interpreterProxy primitiveFail].
	bits := interpreterProxy fetchPointer: 0 ofObject: form.
	w := interpreterProxy fetchInteger: 1 ofObject: form.
	h := interpreterProxy fetchInteger: 2 ofObject: form.
	d := interpreterProxy fetchInteger: 3 ofObject: form.
	ppw := 32 // d.
	(interpreterProxy isWords: bits)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: bits) = (w + ppw - 1 // ppw * h)
		ifFalse:[^interpreterProxy primitiveFail].
	bitsPtr := interpreterProxy firstIndexableField: bits.
	handle := interpreterProxy stackIntegerValue: 1.
	renderer := interpreterProxy stackIntegerValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode:'b3dxUploadTexture(renderer, handle, w, h, d, bitsPtr)' inSmalltalk:[false].
	result ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 3. "args; return rcvr"