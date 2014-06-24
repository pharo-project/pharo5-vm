testing
testRequiresNativeFloatWordOrder
	"Required for Cog and StackInterpreter"

	| v |
	v := ImageFormat wordSize: 4.
	self deny: v requiresNativeFloatWordOrder.
	v setCogSupportRequirement: false.
	self assert: v asInteger = 6502.
	self deny: v requiresNativeFloatWordOrder.
	v setCogSupportRequirement: true.
	self assert: v asInteger = 6505.
	self assert: v requiresNativeFloatWordOrder.
	v setSpurSupportRequirement: true.
	self assert: v asInteger = 6521.

	v := ImageFormat wordSize: 8.
	self deny: v requiresNativeFloatWordOrder.
	v setCogSupportRequirement: false.
	self assert: v asInteger = 68000.
	self deny: v requiresNativeFloatWordOrder.
	v setCogSupportRequirement: true.
	self assert: v asInteger = 68003.
	self assert: v requiresNativeFloatWordOrder.
	v setSpurSupportRequirement: true.
	self assert: v asInteger = 68019.
	
	self deny: (ImageFormat wordSize: 4 cog: false) requiresNativeFloatWordOrder.
	self deny: (ImageFormat wordSize: 4 cog: false) requiresClosureSupport.
	self deny: (ImageFormat wordSize: 8 cog: false) requiresNativeFloatWordOrder.
	self deny: (ImageFormat wordSize: 8 cog: false) requiresClosureSupport.
	self assert: (ImageFormat wordSize: 4 cog: true) requiresNativeFloatWordOrder.
	self assert: (ImageFormat wordSize: 4 cog: true) requiresClosureSupport.
	self assert: (ImageFormat wordSize: 8 cog: true) requiresNativeFloatWordOrder.
	self assert: (ImageFormat wordSize: 8 cog: true) requiresClosureSupport.
	self assert: (ImageFormat fromInteger: 6521) requiresNativeFloatWordOrder.
	self assert: (ImageFormat fromInteger: 6521) requiresClosureSupport.
	self assert: (ImageFormat fromInteger: 68019) requiresNativeFloatWordOrder.
	self assert: (ImageFormat fromInteger: 68019) requiresClosureSupport.
