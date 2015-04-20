primitives-FT2Face
primitiveSetFaceCharMap: encodingString 
	| face rcvr encoding |
	
	<var: #face declareC: 'FT_Face face'>
	<var: #encoding declareC: 'FT_Encoding encoding'>
	
	rcvr := self 
				primitive: 'primitiveSetFaceCharMap'
				parameters: #(#Oop)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	encoding := self ftEncodingValueFromString: encodingString.
	interpreterProxy failed ifTrue: [^nil].
	self touch: encoding.
	errorCode := self cCode: 'FT_Select_Charmap(face, encoding)'.
	interpreterProxy success: errorCode == 0.
	interpreterProxy failed ifTrue: [^nil]