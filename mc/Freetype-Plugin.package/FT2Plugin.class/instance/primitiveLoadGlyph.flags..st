primitives-FT2Face
primitiveLoadGlyph: index flags: flags 
	| face rcvr |
	
	<var: #face declareC: 'FT_Face face'>
	
	rcvr := self 
				primitive: 'primitiveLoadGlyph'
				parameters: #(#SmallInteger #SmallInteger)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	errorCode := self cCode: 'FT_Load_Glyph(face, index, flags)'.
	interpreterProxy success: errorCode == 0.
	interpreterProxy failed ifTrue: [^nil]