simulation stack
ssStorePop: popBoolean toReg: reg
	"Store or pop the top simulated stack entry to a register.
	N.B.: popToReg: and storeToReg: does not generate anything if 
	it moves a register to the same register."	
	popBoolean
		ifTrue: [self ssTop popToReg: reg.
				self ssPop: 1]
		ifFalse: [self ssTop storeToReg: reg].