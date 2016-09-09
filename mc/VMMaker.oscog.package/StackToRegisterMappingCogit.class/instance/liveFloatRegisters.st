simulation stack
liveFloatRegisters
	| regsSet |
	regsSet := 0.
	(simSpillBase max: 0) to: simStackPtr do:
		[:i|
		regsSet := regsSet bitOr: (self simStackAt: i) floatRegisterMask].
	self cppIf: LowcodeVM ifTrue: [ 
		(simNativeSpillBase max: 0) to: simNativeStackPtr do:
			[:i|
			regsSet := regsSet bitOr: (self simNativeStackAt: i) nativeFloatRegisterMask].
	].
	^regsSet