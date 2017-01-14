primitives
primitiveIdctInt
	"In:
		anArray: IntegerArray new: DCTSize2
		qt: IntegerArray new: DCTSize2.
	"
	| arrayOop anArray qt |
	<export: true>
	<var: #anArray type: #'int *'>
	<var: #qt type: #'int *'>
	self cCode:'' inSmalltalk:[self stInit].
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	arrayOop := interpreterProxy stackValue: 0.
	((interpreterProxy isWords: arrayOop) and:[(interpreterProxy slotSizeOf: arrayOop) = DCTSize2])
		ifFalse:[^interpreterProxy primitiveFail].
	qt := interpreterProxy firstIndexableField: arrayOop.
	arrayOop := interpreterProxy stackValue: 1.
	((interpreterProxy isWords: arrayOop) and:[(interpreterProxy slotSizeOf: arrayOop) = DCTSize2])
		ifFalse:[^interpreterProxy primitiveFail].
	anArray := interpreterProxy firstIndexableField: arrayOop.
	self idctBlockInt: anArray qt: qt.
	interpreterProxy pop: 2