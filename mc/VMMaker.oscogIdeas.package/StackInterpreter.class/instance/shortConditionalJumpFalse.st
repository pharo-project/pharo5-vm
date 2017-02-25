jump bytecodes
shortConditionalJumpFalse

	self jumplfFalseBy: (currentBytecode bitAnd: 7) + 1