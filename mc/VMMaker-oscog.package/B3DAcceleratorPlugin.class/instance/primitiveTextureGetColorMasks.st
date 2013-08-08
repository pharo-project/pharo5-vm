primitives-textures
primitiveTextureGetColorMasks
	| handle result masks array renderer arrayOop |
	<export: true>
	<var: #masks declareC:'int masks[4]'>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	array := interpreterProxy stackObjectValue: 0.
	handle := interpreterProxy stackIntegerValue: 1.
	renderer := interpreterProxy stackIntegerValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy fetchClassOf: array) = interpreterProxy classArray
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: array) = 4
		ifFalse:[^interpreterProxy primitiveFail].
	result := self cCode:'b3dxTextureColorMasks(renderer, handle, masks)' inSmalltalk:[false].
	result ifFalse:[^interpreterProxy primitiveFail].
	arrayOop := array.
	0 to: 3 do:[:i|
		interpreterProxy pushRemappableOop: arrayOop.
		result := interpreterProxy positive32BitIntegerFor: (masks at: i).
		arrayOop := interpreterProxy popRemappableOop.
		interpreterProxy storePointer: i ofObject: arrayOop withValue: result].
	^interpreterProxy pop: 3. "pop args return receiver"