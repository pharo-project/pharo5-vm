simulation stack
ssStoreAndReplacePop: popBoolean toReg: reg
	"In addition to ssStorePop:toReg:, if this is a store and not
	a popInto and the top of the simulated stack is not spilled,
	I change the simulated stack to use the register for the value"
	| topSpilled |
	topSpilled := self ssTop spilled.
	self ssStorePop: (popBoolean or: [topSpilled]) toReg: reg.
	popBoolean ifFalse: 
		[ topSpilled ifFalse: [self ssPop: 1].
		self ssPushRegister: reg ].