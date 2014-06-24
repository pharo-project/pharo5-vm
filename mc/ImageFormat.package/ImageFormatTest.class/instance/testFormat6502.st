testing
testFormat6502

	self assert: ImageFormat default asInteger = 6502.
	self assert: (ImageFormat wordSize: 4) asInteger = 6502.
	self assert: (ImageFormat wordSize: 4 closures: false) asInteger = 6502.
	self assert: (ImageFormat fromInteger: 6502) asInteger = 6502.
	self assert: ImageFormat default wordSize = 4.
	self deny: ImageFormat default requiresClosureSupport.
	self deny: ImageFormat default requiresNativeFloatWordOrder.
	self assert: ImageFormat default is32Bit.
	self deny: ImageFormat default is64Bit.
	self assert: (ImageFormat fromInteger: 6502) asInteger = 6502
