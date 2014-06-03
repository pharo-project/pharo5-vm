Integer primitives
primDigitBitXor: secondInteger 
	"Bit logic here is only implemented for positive integers or Zero; if rec 
	or arg is negative, it fails."
	| firstInteger |
	self debugCode: [self msg: 'primDigitBitXor: secondInteger'].
	firstInteger := self
				primitive: 'primDigitBitXor'
				parameters: #(Integer )
				receiver: #Integer.
	^ self
		digitBitLogic: firstInteger
		with: secondInteger
		opIndex: xorOpIndex