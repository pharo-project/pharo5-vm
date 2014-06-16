testing
testFormat6504

	| defaultWithClosures |
	defaultWithClosures := ImageFormat default setClosureSupportRequirement: true.
	self assert: defaultWithClosures asInteger = 6504.
	self assert: (ImageFormat wordSize: 4 closures: true) asInteger = 6504.
	self assert: (ImageFormat fromInteger: 6504) asInteger = 6504.
	self assert: defaultWithClosures wordSize = 4.
	self assert: defaultWithClosures requiresClosureSupport.
	self deny: defaultWithClosures requiresNativeFloatWordOrder.
	self assert: defaultWithClosures is32Bit.
	self deny: defaultWithClosures is64Bit.
	self assert: (ImageFormat fromInteger: 6504) asInteger = 6504
