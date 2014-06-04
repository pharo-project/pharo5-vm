stack bytecodes
storeAndPopTemporaryVariableBytecode
	<expandCases>
	self
		cCode: "this bytecode will be expanded so that refs to currentBytecode below will be constant"
			[self fetchNextBytecode.
			 self storePointerUnchecked: (currentBytecode bitAnd: 7) + TempFrameStart
				ofObject: localHomeContext
				withValue: self internalStackTop.
			self internalPop: 1]
		inSmalltalk: "Interpreter version has fetchNextBytecode out of order"
			[self storePointerUnchecked: (currentBytecode bitAnd: 7) + TempFrameStart
				ofObject: localHomeContext
				withValue: self internalStackTop.
			self internalPop: 1.
			self fetchNextBytecode]