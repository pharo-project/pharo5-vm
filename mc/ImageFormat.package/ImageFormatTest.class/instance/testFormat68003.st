testing
testFormat68003

	| cog64 |
	cog64 := (ImageFormat wordSize: 8) setCogSupportRequirement: true.
	self assert: cog64 asInteger = 68003.
	self assert: (ImageFormat wordSize: 8 cog: true) asInteger = 68003.
	self assert: (ImageFormat fromInteger: 68003) asInteger = 68003.
	self assert: cog64 wordSize = 8.
	self assert: cog64 requiresClosureSupport.
	self assert: cog64 requiresNativeFloatWordOrder.
	self deny: cog64 is32Bit.
	self assert: cog64 is64Bit.
	self assert: (ImageFormat fromInteger: 68003) asInteger = 68003