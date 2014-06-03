jump bytecodes
shortConditionalJumpTrue

	self jumplfTrueBy: (currentBytecode bitAnd: 7) + 1