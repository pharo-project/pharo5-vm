decoding
cbColorComponentFrom: oop
	^(self colorComponent: cbComponent from: oop)
		and:[self colorComponentBlocks: cbBlocks from: oop]