stack bytecodes
pushLiteralVariable16CasesBytecode
	<expandCases>
	self
		cCode: "this bytecode will be expanded so that refs to currentBytecode below will be constant"
			[self fetchNextBytecode.
			 self pushLiteralVariable: (currentBytecode bitAnd: 16rF)]
		inSmalltalk: "Interpreter version has fetchNextBytecode out of order"
			[self pushLiteralVariable: (currentBytecode bitAnd: 16rF).
			 self fetchNextBytecode]