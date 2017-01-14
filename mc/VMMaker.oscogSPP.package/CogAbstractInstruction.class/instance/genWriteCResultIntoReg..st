abi
genWriteCResultIntoReg: abstractRegister
	| cResultReg |
	cResultReg := self cResultRegister.
	abstractRegister ~= cResultReg ifTrue:
		[cogit gen: MoveRR operand: cResultReg operand: abstractRegister]