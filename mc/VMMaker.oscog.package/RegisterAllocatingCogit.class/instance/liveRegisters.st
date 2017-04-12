simulation stack
liveRegisters
	| regsSet |
	needsFrame
		ifTrue: [regsSet := 0]
		ifFalse:
			[regsSet := (methodOrBlockNumArgs > self numRegArgs
						  or: [methodOrBlockNumArgs = 0])
							ifTrue:
								[self registerMaskFor: ReceiverResultReg]
							ifFalse:
								[(self numRegArgs > 1 and: [methodOrBlockNumArgs > 1])
									ifFalse: [self registerMaskFor: ReceiverResultReg and: Arg0Reg]
									ifTrue: [self registerMaskFor: ReceiverResultReg and: Arg0Reg and: Arg1Reg]]].
	0 to: simStackPtr do:
		[:i|
		regsSet := regsSet bitOr: (self simStackAt: i) registerMask].
	LowcodeVM ifTrue:
		[(simNativeSpillBase max: 0) to: simNativeStackPtr do:
			[:i|
			regsSet := regsSet bitOr: (self simNativeStackAt: i) nativeRegisterMask]].
	^regsSet