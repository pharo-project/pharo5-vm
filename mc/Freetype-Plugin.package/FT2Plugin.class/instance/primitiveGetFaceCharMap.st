primitives-FT2Face
primitiveGetFaceCharMap
	| face rcvr encoding stringOop charmap |
	
	<var: #face declareC: 'FT_Face face'>
	<var: #charmap type: 'FT_CharMap'>
	<var: #encoding declareC: 'FT_Encoding encoding'>
	
	rcvr := self 
				primitive: 'primitiveGetFaceCharMap'
				parameters: #()
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	charmap := self cCode: 'face->charmap'.
	charmap ifFalse: [^nil].

	"encoding 22"
	interpreterProxy pushRemappableOop: rcvr.
	encoding := self cCode: 'charmap->encoding'.
	stringOop := self ftStringFromEncodingValue: encoding.
	rcvr := interpreterProxy popRemappableOop.
	interpreterProxy 
		storePointer: 22
		ofObject: rcvr
		withValue: stringOop.

	"platformId 23"
	interpreterProxy 
		storeInteger: 23
		ofObject: rcvr
		withValue: (self cCode: 'charmap->platform_id').

	"encodingId 24"
	interpreterProxy 
		storeInteger: 24
		ofObject: rcvr
		withValue: (self cCode: 'charmap->encoding_id').
	interpreterProxy failed ifTrue: [^nil]