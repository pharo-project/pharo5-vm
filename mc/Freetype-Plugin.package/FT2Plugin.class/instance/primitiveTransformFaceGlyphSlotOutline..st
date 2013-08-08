primitives-FT2Face
primitiveTransformFaceGlyphSlotOutline: matrixWordArray

	| face matrix rcvr matrixsqIntPtr |
	self var: #face declareC: 'FT_Face face'.
	self var: #matrix declareC: 'FT_Matrix matrix'.
	self var: #matrixsqIntPtr declareC: 'sqInt *matrixsqIntPtr'.
	rcvr := self 
				primitive: 'primitiveTransformFaceGlyphSlotOutline'
				parameters: #(Oop)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	matrixsqIntPtr := interpreterProxy arrayValueOf: matrixWordArray.
	self cCode: 'matrix.xx = matrixsqIntPtr[0]; matrix.xy = matrixsqIntPtr[1]; 
		matrix.yx = matrixsqIntPtr[2]; matrix.yy = matrixsqIntPtr[3]; '.
	interpreterProxy failed
		ifFalse:[
			self cCode: 'FT_Outline_Transform( &face->glyph->outline, &matrix )'  inSmalltalk: [
				self touch: matrix]]
	