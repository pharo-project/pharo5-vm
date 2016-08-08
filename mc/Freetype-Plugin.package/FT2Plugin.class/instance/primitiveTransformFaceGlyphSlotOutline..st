primitives-FT2Face
primitiveTransformFaceGlyphSlotOutline: matrixWordArray
	| face matrix rcvr matrixsqIntPtr |
	
	<var: #face declareC: 'FT_Face face'>
	<var: #matrix declareC: 'FT_Matrix matrix = {0}'>
	<var: #matrixsqIntPtr declareC: 'int *matrixsqIntPtr'>
	
	rcvr := self 
				primitive: 'primitiveTransformFaceGlyphSlotOutline'
				parameters: #(Oop)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	matrixsqIntPtr := self cCoerce: (interpreterProxy arrayValueOf: matrixWordArray) to: 'int *'.
	self cCode: 'matrix.xx = matrixsqIntPtr[0]; matrix.xy = matrixsqIntPtr[1]; 
		matrix.yx = matrixsqIntPtr[2]; matrix.yy = matrixsqIntPtr[3]; '.
	interpreterProxy failed
		ifFalse:[
			self cCode: 'FT_Outline_Transform( &face->glyph->outline, &matrix )'  inSmalltalk: [
				self touch: matrix]]
	