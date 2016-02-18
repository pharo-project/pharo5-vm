primitives-FT2Face
primitiveSetPixelWidth: x height: y 
	| face rcvr |
	
	<var: #face declareC: 'FT_Face face'>
	
	rcvr := self 
				primitive: 'primitiveSetPixelSizes'
				parameters: #(#SmallInteger #SmallInteger)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	errorCode := self cCode: 'FT_Set_Pixel_Sizes(face, x, y)'.
	interpreterProxy success: errorCode == 0.
	interpreterProxy failed ifTrue: [^nil]