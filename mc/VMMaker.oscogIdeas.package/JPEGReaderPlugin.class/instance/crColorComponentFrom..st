decoding
crColorComponentFrom: oop
	^(self colorComponent: crComponent from: oop)
		and:[self colorComponentBlocks: crBlocks from: oop]