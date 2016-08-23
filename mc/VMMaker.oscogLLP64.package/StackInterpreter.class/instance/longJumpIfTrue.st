jump bytecodes
longJumpIfTrue

	self jumplfTrueBy: ((currentBytecode bitAnd: 3) * 256) + self fetchByte.