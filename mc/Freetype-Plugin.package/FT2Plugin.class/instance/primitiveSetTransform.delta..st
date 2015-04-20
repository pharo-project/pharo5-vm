primitives-FT2Face
primitiveSetTransform: matrixWordArray delta: deltaWordArray
	| face rcvr matrix delta deltasqIntPtr matrixsqIntPtr |
	
	<var: #face declareC: 'FT_Face face'>
	<var: #matrix declareC: 'FT_Matrix matrix'>
	<var: #matrixsqIntPtr declareC: 'sqInt *matrixsqIntPtr'>
	<var: #delta declareC: 'FT_Vector delta'>
	<var: #deltasqIntPtr  declareC: 'sqInt *deltasqIntPtr'>

	rcvr := self 
				primitive: 'primitiveSetTransform'
				parameters: #(Oop Oop)
				receiver: #FT2Face.
	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	matrixsqIntPtr := interpreterProxy arrayValueOf: matrixWordArray.
	deltasqIntPtr := interpreterProxy arrayValueOf: deltaWordArray.
	self cCode: 'delta.x = deltasqIntPtr[0]; delta.y = deltasqIntPtr[1];'.
	self cCode: 'matrix.xx = matrixsqIntPtr[0]; matrix.xy = matrixsqIntPtr[1]; 
		matrix.yx = matrixsqIntPtr[2]; matrix.yy = matrixsqIntPtr[3]; '.
	interpreterProxy failed
		ifFalse:[
			self cCode: 'FT_Set_Transform( face, &matrix, &delta)' inSmalltalk: [
				self touch: matrix.
				self touch: delta]].
