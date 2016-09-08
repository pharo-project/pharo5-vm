primitives-textures
primitiveTextureGetColorMasks
	| handle masks array renderer |
	<export: true>
	<var: #masks declareC:'unsigned int masks[4]'>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	array := interpreterProxy stackObjectValue: 0.
	handle := interpreterProxy stackIntegerValue: 1.
	renderer := interpreterProxy stackIntegerValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	((interpreterProxy isArray: array)
	 and: [(interpreterProxy slotSizeOf: array) = 4
	 and: [self cCode:'b3dxTextureColorMasks(renderer, handle, masks)' inSmalltalk:[false]]])
		ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy pushRemappableOop: array.
	0 to: 3 do: [:i|
		interpreterProxy
			storePointer: i
			ofObject: interpreterProxy topRemappableOop
			withValue: (interpreterProxy positive32BitIntegerFor: (masks at: i))].
	interpreterProxy popRemappableOop.
	^interpreterProxy pop: 3 "pop args return receiver"