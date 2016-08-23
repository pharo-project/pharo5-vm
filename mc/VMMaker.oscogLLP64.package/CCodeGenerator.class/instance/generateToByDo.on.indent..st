C translation
generateToByDo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	"N.B. MessageNode>>asTranslatorNodeIn: adds the limit var as a hidden fourth argument."
	| blockExpr iterationVar limitExpr mayHaveSideEffects limitVar step |
	blockExpr := msgNode args third.
	blockExpr args size = 1 ifFalse:
		[self error: 'wrong number of block arguments'].
	iterationVar := blockExpr args first.
	limitExpr := msgNode args first.
	aStream nextPutAll: 'for (', iterationVar, ' = '.
	self emitCExpression: msgNode receiver on: aStream.
	mayHaveSideEffects := msgNode args size = 4. "See TMethod>>prepareMethodIn:"
	mayHaveSideEffects ifTrue:
		[limitVar := msgNode args last.
		 aStream nextPutAll: ', ', limitVar name, ' = '.
		 self emitCExpression: limitExpr on: aStream.
		 limitExpr := limitVar].
	aStream nextPutAll: '; ', iterationVar.
	step := msgNode args at: 2.
	self generateToByDoLimitExpression: limitExpr
		negative: (self stepExpressionIsNegative: step)
		on: aStream.
	aStream nextPutAll: '; ', iterationVar, ' += '.
	self emitCExpression: step on: aStream.
	aStream nextPutAll: ') {'; cr.
	blockExpr emitCCodeOn: aStream level: level + 1 generator: self.
	aStream tab: level.
	aStream nextPut: $}