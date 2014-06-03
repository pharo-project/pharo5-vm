development primitives
primDigitBitLogic: firstInteger with: secondInteger op: opIndex 
	"Bit logic here is only implemented for positive integers or Zero; if any arg is negative, it fails."
	self debugCode: [self msg: 'primDigitBitLogic: firstInteger with: secondInteger op: opIndex'].
	self
		primitive: 'primDigitBitLogicWithOp'
		parameters: #(Integer Integer SmallInteger )
		receiver: #Oop.
	^ self
		digitBitLogic: firstInteger
		with: secondInteger
		opIndex: opIndex