simulation stack
liveRegisters
	| regsSet |
	needsFrame
		ifTrue: [regsSet := 0]
		ifFalse:
			[regsSet := self registerMaskFor: ReceiverResultReg.
			 (methodOrBlockNumArgs <= self numRegArgs
			  and: [methodOrBlockNumArgs > 0]) ifTrue:
				[regsSet := regsSet bitOr: (self registerMaskFor: Arg0Reg).
				 (self numRegArgs > 1 and: [methodOrBlockNumArgs > 1]) ifTrue:
					[regsSet := regsSet bitOr: (self registerMaskFor: Arg1Reg)]]].
	(simSpillBase max: 0) to: simStackPtr do:
		[:i|
		regsSet := regsSet bitOr: (self simStackAt: i) registerMask].
	LowcodeVM ifTrue: [ 
		(simNativeSpillBase max: 0) to: simNativeStackPtr do:
			[:i|
			regsSet := regsSet bitOr: (self simNativeStackAt: i) nativeRegisterMask].
	].
	^regsSet