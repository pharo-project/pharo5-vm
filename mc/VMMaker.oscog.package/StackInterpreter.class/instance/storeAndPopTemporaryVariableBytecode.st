stack bytecodes
storeAndPopTemporaryVariableBytecode
	<expandCases>
	self
		cCode: "this bytecode will be expanded so that refs to currentBytecode below will be constant"
			[self fetchNextBytecode.
			 self temporary: (currentBytecode bitAnd: 7) in: localFP put: self internalStackTop.
			 self internalPop: 1]
		inSmalltalk: "Interpreter version has fetchNextBytecode out of order"
			[self temporary: (currentBytecode bitAnd: 7) in: localFP put: self internalStackTop.
			 self fetchNextBytecode.
			 self internalPop: 1]