jump bytecodes
shortUnconditionalJump
	<expandCases>
	self jump: (currentBytecode bitAnd: 7) + 1.