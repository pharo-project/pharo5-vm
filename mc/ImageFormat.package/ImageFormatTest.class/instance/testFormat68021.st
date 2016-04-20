testing
testFormat68021

	| spur |
	spur := ImageFormat fromInteger: 68021.
	self assert: spur asInteger = 68021.
	self assert: (ImageFormat wordSize: 8 spur: true) asInteger = 68021.
	self assert: (ImageFormat fromInteger: 68021) asInteger = 68021.
	self assert: spur wordSize = 8.
	self assert: spur requiresClosureSupport.
	self assert: spur requiresNativeFloatWordOrder.
	self deny: spur is32Bit.
	self assert: spur is64Bit.
	self assert: spur requiresSpurSupport.
	self assert: (ImageFormat fromInteger: 68021) asInteger = 68021