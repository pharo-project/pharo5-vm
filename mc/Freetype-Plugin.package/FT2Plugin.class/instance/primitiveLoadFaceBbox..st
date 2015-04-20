primitives-FT2Face
primitiveLoadFaceBbox: aRectangle 
	| rcvr face pointOop rectOop |
	<var: #face type: 'FT_Face'>
	rcvr := self 
				primitive: 'primitiveLoadFaceBbox'
				parameters: #(#Rectangle)
				receiver: #FT2Face.
	rectOop := aRectangle.
	(interpreterProxy isPointers: rectOop) 
		ifFalse: [^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: rectOop) < 2 
		ifTrue: [^interpreterProxy primitiveFail].
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	self touch: face.

	"handle is first slot and is already loaded."
	(self cCode: 'face->face_flags & FT_FACE_FLAG_SCALABLE') 
		ifFalse: [interpreterProxy success: false].
	interpreterProxy failed ifTrue: [^nil].

	"origin"
	interpreterProxy pushRemappableOop: rectOop.
	pointOop := interpreterProxy 
				makePointwithxValue: (self cCode: 'face->bbox.xMin')
				yValue: (self cCode: 'face->bbox.yMin').
	rectOop := interpreterProxy popRemappableOop.
	interpreterProxy 
		storePointer: 0
		ofObject: rectOop
		withValue: pointOop.

	"corner"
	interpreterProxy pushRemappableOop: rectOop.
	pointOop := interpreterProxy 
				makePointwithxValue: (self cCode: 'face->bbox.xMax')
				yValue: (self cCode: 'face->bbox.yMax').
	rectOop := interpreterProxy popRemappableOop.
	interpreterProxy 
		storePointer: 1
		ofObject: rectOop
		withValue: pointOop