abi
genWriteCSecondResultIntoReg: abstractRegister
	<option: #LowcodeVM>
	| cResultReg |
	cResultReg := self cResultRegisterHigh.
	abstractRegister ~= cResultReg ifTrue:
		[cogit gen: MoveRR operand: cResultReg operand: abstractRegister]