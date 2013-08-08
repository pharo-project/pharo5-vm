primitives-FT2Face
primitiveGetFaceCharMapsInto: array 
	| face rcvr stringOop charmap numCharmaps arrayOop |
	self var: #face type: 'FT_Face'.
	self var: #charmap type: 'FT_CharMap *'.
	self var: #numCharmaps type: 'int'.
	rcvr := self 
				primitive: 'primitiveGetFaceCharMapsIntoArray'
				parameters: #(#Array)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	numCharmaps := self cCode: 'face->num_charmaps'.
	arrayOop := array asOop: String.
	interpreterProxy 
		success: (interpreterProxy slotSizeOf: arrayOop) == numCharmaps.
	interpreterProxy failed ifTrue: [^nil].
	charmap := self cCode: 'face->charmaps'.
	self touch: charmap.
	0 to: numCharmaps - 1
		do: 
			[:i | 
			interpreterProxy pushRemappableOop: arrayOop.
			stringOop := self 
						ftStringFromEncodingValue: (self cCode: '(*charmap)->encoding').
			arrayOop := interpreterProxy popRemappableOop.
			interpreterProxy 
				storePointer: i
				ofObject: arrayOop
				withValue: stringOop.
			self cCode: 'charmap++'].
	interpreterProxy failed ifTrue: [^nil]