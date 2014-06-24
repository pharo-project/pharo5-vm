testing
testRequiresClosureSupport

	| v |
	v := ImageFormat wordSize: 4.
	self deny: v requiresClosureSupport.
	v setClosureSupportRequirement: false.
	self assert: v asInteger = 6502.
	self deny: v requiresClosureSupport.
	v setClosureSupportRequirement: true.
	self assert: v asInteger = 6504.
	self assert: v requiresClosureSupport.

	v := ImageFormat wordSize: 8.
	self deny: v requiresClosureSupport.
	v setClosureSupportRequirement: false.
	self assert: v asInteger = 68000.
	self deny: v requiresClosureSupport.
	v setClosureSupportRequirement: true.
	self assert: v asInteger = 68002.
	self assert: v requiresClosureSupport.
	
	self deny: (ImageFormat wordSize: 4 closures: false) requiresClosureSupport.
	self assert: (ImageFormat wordSize: 4 closures: true) requiresClosureSupport.
	self deny: (ImageFormat wordSize: 8 closures: false) requiresClosureSupport.
	self assert: (ImageFormat wordSize: 8 closures: true) requiresClosureSupport.
