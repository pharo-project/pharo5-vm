primitives-FT2Face
primitiveEmboldenFaceGlyphSlotOutline: strength
	"emboldens the outline in the face's glyphSlot by strength (expressed in 26.6 pixel format).
	The new outline will be at most 4 times `strength' pixels wider and higher. "
	| face rcvr |
	
	<var: #face declareC: 'FT_Face face'>
	
	rcvr := self 
				primitive: 'primitiveEmboldenFaceGlyphSlotOutline'
				parameters: #(#SmallInteger)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	errorCode := self cCode: 'FT_Outline_Embolden( &face->glyph->outline, strength )'.
	interpreterProxy success: errorCode == 0.
	interpreterProxy failed ifTrue: [^nil]