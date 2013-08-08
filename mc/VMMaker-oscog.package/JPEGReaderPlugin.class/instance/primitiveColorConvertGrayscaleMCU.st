primitives
primitiveColorConvertGrayscaleMCU
	"Requires:
		JPEGColorComponent
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
	arrayOop := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	((interpreterProxy isWords: arrayOop) and:[(interpreterProxy slotSizeOf: arrayOop) = 3])
		ifFalse:[^interpreterProxy primitiveFail].
	residuals := interpreterProxy firstIndexableField: arrayOop.
	arrayOop := interpreterProxy stackObjectValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isWords: arrayOop)
		ifFalse:[^interpreterProxy primitiveFail].
	jpegBitsSize := interpreterProxy slotSizeOf: arrayOop.
	jpegBits := interpreterProxy firstIndexableField: arrayOop.
	arrayOop := interpreterProxy stackObjectValue: 3.
	interpreterProxy failed ifTrue:[^nil].
	(self yColorComponentFrom: arrayOop)
		ifFalse:[^interpreterProxy primitiveFail].
	self colorConvertGrayscaleMCU.
	interpreterProxy pop: 4.