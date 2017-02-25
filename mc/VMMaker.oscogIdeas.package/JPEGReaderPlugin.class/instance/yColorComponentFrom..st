decoding
yColorComponentFrom: oop
	^(self colorComponent: yComponent from: oop)
		and:[self colorComponentBlocks: yBlocks from: oop]