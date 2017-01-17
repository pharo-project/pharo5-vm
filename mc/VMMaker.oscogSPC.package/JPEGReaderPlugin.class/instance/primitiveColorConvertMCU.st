primitives
primitiveColorConvertMCU
	"Requires:
		Array with: 3*JPEGColorComponent
		bits
		WordArray with: 3*Integer (residuals)
		ditherMask
	"
	| arrayOop |
	<export: true>
	self stInit.
	interpreterProxy methodArgumentCount = 4
		ifFalse:[^interpreterProxy primitiveFail].
	ditherMask := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	arrayOop := interpreterProxy stackValue: 1.
	((interpreterProxy isWords: arrayOop) and:[(interpreterProxy slotSizeOf: arrayOop) = 3])
		ifFalse:[^interpreterProxy primitiveFail].
	residuals := interpreterProxy firstIndexableField: arrayOop.
	arrayOop := interpreterProxy stackValue: 2.
	(interpreterProxy isWords: arrayOop)
		ifFalse:[^interpreterProxy primitiveFail].
	jpegBitsSize := interpreterProxy slotSizeOf: arrayOop.
	jpegBits := interpreterProxy firstIndexableField: arrayOop.
	arrayOop := interpreterProxy stackValue: 3.
	((interpreterProxy isPointers: arrayOop) and:[(interpreterProxy slotSizeOf: arrayOop) = 3])
		ifFalse:[^interpreterProxy primitiveFail].
	(self yColorComponentFrom: (interpreterProxy fetchPointer: 0 ofObject: arrayOop))
		ifFalse:[^interpreterProxy primitiveFail].
	(self cbColorComponentFrom: (interpreterProxy fetchPointer: 1 ofObject: arrayOop))
		ifFalse:[^interpreterProxy primitiveFail].
	(self crColorComponentFrom: (interpreterProxy fetchPointer: 2 ofObject: arrayOop))
		ifFalse:[^interpreterProxy primitiveFail].
	self colorConvertMCU.
	interpreterProxy pop: 4