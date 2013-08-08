primitives
primitiveDecodeMCU
	"In:
		anArray 		WordArray of: DCTSize2
		aColorComponent JPEGColorComponent
		dcTable			WordArray
		acTable			WordArray
		stream			JPEGStream
	"
	| arrayOop oop anArray |
	<export: true>
	<var: #anArray type: 'int *'>
	self cCode:'' inSmalltalk:[self stInit].

	interpreterProxy methodArgumentCount = 5 
		ifFalse:[^interpreterProxy primitiveFail].

	oop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	(self loadJPEGStreamFrom: oop)
		ifFalse:[^interpreterProxy primitiveFail].

	arrayOop := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isWords: arrayOop)
		ifFalse:[^interpreterProxy primitiveFail].
	acTableSize := interpreterProxy slotSizeOf: arrayOop.
	acTable := interpreterProxy firstIndexableField: arrayOop.

	arrayOop := interpreterProxy stackObjectValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isWords: arrayOop)
		ifFalse:[^interpreterProxy primitiveFail].
	dcTableSize := interpreterProxy slotSizeOf: arrayOop.
	dcTable := interpreterProxy firstIndexableField: arrayOop.

	oop := interpreterProxy stackObjectValue: 3.
	interpreterProxy failed ifTrue:[^nil].
	(self colorComponent: yComponent from: oop)
		ifFalse:[^interpreterProxy primitiveFail].

	arrayOop := interpreterProxy stackObjectValue: 4.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isWords: arrayOop)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: arrayOop) = DCTSize2
		ifFalse:[^interpreterProxy primitiveFail].
	anArray := interpreterProxy firstIndexableField: arrayOop.

	interpreterProxy failed ifTrue:[^nil].

	self decodeBlockInto: anArray component: yComponent.

	interpreterProxy failed ifTrue:[^nil].
	self storeJPEGStreamOn: (interpreterProxy stackValue: 0).
	interpreterProxy 
		storeInteger: PriorDCValueIndex 
		ofObject: (interpreterProxy stackValue: 3) 
		withValue: (yComponent at: PriorDCValueIndex).

	interpreterProxy pop: 5.