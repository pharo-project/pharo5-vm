abstract instructions
isPCRelativeAddress: operand
	"Provided the receiver's address has been determined we can
	 answer if operand can be accessed via pc-relative addressing."

	self assert: address notNil.
	^operand between: address + 8 - (1 << 12 - 1) and: address + 8 + (1 << 12 - 1)