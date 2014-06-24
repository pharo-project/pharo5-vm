testing
testFormat6521

	| spur |
	spur := ImageFormat fromInteger: 6521.
	self assert: spur asInteger = 6521.
	self assert: (ImageFormat wordSize: 4 spur: true) asInteger = 6521.
	self assert: (ImageFormat fromInteger: 6521) asInteger = 6521.
	self assert: spur wordSize = 4.
	self assert: spur requiresClosureSupport.
	self assert: spur requiresNativeFloatWordOrder.
	self assert: spur is32Bit.
	self deny: spur is64Bit.
	self assert: spur requiresSpurSupport.
	self assert: (ImageFormat fromInteger: 6521) asInteger = 6521