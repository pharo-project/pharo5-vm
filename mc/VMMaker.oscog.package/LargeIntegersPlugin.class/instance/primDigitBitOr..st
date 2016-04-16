Integer primitives
primDigitBitOr: secondInteger 
	"Bit logic here is only implemented for positive integers or Zero; if rec 
	or arg is negative, it fails."
	| firstInteger |
	self debugCode: [self msg: 'primDigitBitOr: secondInteger'].
	firstInteger := self primitive: 'primDigitBitOr'.
	^ self
		digitBitLogic: firstInteger
		with: secondInteger
		opIndex: orOpIndex