jump bytecodes
longJumpIfFalse

	self jumplfFalseBy: ((currentBytecode bitAnd: 3) * 256) + self fetchByte.