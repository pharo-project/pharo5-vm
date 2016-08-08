primitives-FT2Face
primitiveTranslateFaceGlyphSlotOutline: deltaWordArray
	| face delta rcvr deltasqIntPtr |
	
	<var: #face declareC: 'FT_Face face'>
	<var: #delta declareC: 'FT_Vector delta = {0}'>
	<var: #deltasqIntPtr  declareC: 'int *deltasqIntPtr'>
	
	rcvr := self 
				primitive: 'primitiveTranslateFaceGlyphSlotOutline'
				parameters: #(Oop)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	deltasqIntPtr := self cCoerce: (interpreterProxy arrayValueOf: deltaWordArray) to: 'int *'.
	self cCode: 'delta.x = deltasqIntPtr[0]; delta.y = deltasqIntPtr[1];'.
	interpreterProxy failed
		ifFalse:[
			self cCode: 'FT_Outline_Translate( &face->glyph->outline, delta.x, delta.y )'  inSmalltalk: [
				self touch: delta]]
	