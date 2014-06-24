testing
testFormat68000

	| closures64 |
	closures64 := ImageFormat wordSize: 8.
	self assert: closures64 asInteger = 68000.
	self assert: (ImageFormat wordSize: 8 closures: false) asInteger = 68000.
	self assert: (ImageFormat fromInteger: 68000) asInteger = 68000.
	self assert: closures64 wordSize = 8.
	self deny: closures64 requiresClosureSupport.
	self deny: closures64 requiresNativeFloatWordOrder.
	self deny: closures64 is32Bit.
	self assert: closures64 is64Bit.
	self assert: (ImageFormat fromInteger: 68000) asInteger = 68000
