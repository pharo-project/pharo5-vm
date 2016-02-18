code generation
compileMethods
	"self compileMethods"

	self compile: self generateProcessBufferWithState
		classified: 'generated'.
	self compile: self generatePrimitiveDecodeState
		classified: 'generated'