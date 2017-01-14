simulation stack
liveRegisters
	| regsSet |
	regsSet := 0.
	0 to: simStackPtr do:
		[:i|
		regsSet := regsSet bitOr: (self simStackAt: i) registerMask].
	LowcodeVM ifTrue:
		[(simNativeSpillBase max: 0) to: simNativeStackPtr do:
			[:i|
			regsSet := regsSet bitOr: (self simNativeStackAt: i) nativeRegisterMask]].
	^regsSet