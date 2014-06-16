testing
testIs64Bit

	self deny: (ImageFormat wordSize: 4) is64Bit.
	self deny: (ImageFormat new fromInteger: 6504) is64Bit.
	self assert: (ImageFormat wordSize: 8) is64Bit.
	self assert: (ImageFormat new fromInteger: 68002) is64Bit.
	self deny: (ImageFormat fromInteger: 6521) is64Bit.
	self assert: (ImageFormat new fromInteger: 68019) is64Bit.
