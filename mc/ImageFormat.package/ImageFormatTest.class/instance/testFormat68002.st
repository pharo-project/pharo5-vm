testing
testFormat68002

	| closures64 |
	closures64 := (ImageFormat wordSize: 8) setClosureSupportRequirement: true.
	self assert: closures64 asInteger = 68002.
	self assert: (ImageFormat wordSize: 8 closures: true) asInteger = 68002.
	self assert: (ImageFormat fromInteger: 68002) asInteger = 68002.
	self assert: closures64 wordSize = 8.
	self assert: closures64 requiresClosureSupport.
	self deny: closures64 requiresNativeFloatWordOrder.
	self deny: closures64 is32Bit.
	self assert: closures64 is64Bit.
	self assert: (ImageFormat fromInteger: 68002) asInteger = 68002