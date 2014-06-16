testing
testFormat6505

	| cog32 |
	cog32 := ImageFormat default
				setCogSupportRequirement: true;
				setClosureSupportRequirement: true.
	self assert: cog32 asInteger = 6505.
	self assert: (ImageFormat wordSize: 4 cog: true) asInteger = 6505.
	self assert: (ImageFormat fromInteger: 6505) asInteger = 6505.
	self assert: cog32 wordSize = 4.
	self assert: cog32 requiresClosureSupport.
	self assert: cog32 requiresNativeFloatWordOrder.
	self assert: cog32 is32Bit.
	self deny: cog32 is64Bit.
	self assert: (ImageFormat fromInteger: 6505) asInteger = 6505