stack bytecodes
pushLiteralVariableBytecode
	<expandCases>
	self
		cCode: "this bytecode will be expanded so that refs to currentBytecode below will be constant"
			[self fetchNextBytecode.
			 self pushLiteralVariable: (currentBytecode bitAnd: 16r1F)]
		inSmalltalk: "Interpreter version has fetchNextBytecode out of order"
			[self pushLiteralVariable: (currentBytecode bitAnd: 16r1F).
			 self fetchNextBytecode]