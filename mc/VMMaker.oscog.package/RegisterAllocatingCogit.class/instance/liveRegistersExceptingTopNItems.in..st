simulation stack
liveRegistersExceptingTopNItems: n in: aSimStack
	<var: 'aSimStack' type: #'SimStackEntry *'>
	| regsSet |
	regsSet := 0.
	0 to: simStackPtr - n do:
		[:i|
		regsSet := regsSet bitOr: (self simStack: aSimStack at: i) registerMask].
	LowcodeVM ifTrue:
		[self shouldBeImplemented.
		 (simNativeSpillBase max: 0) to: simNativeStackPtr - n do:
			[:i|
			regsSet := regsSet bitOr: (self simNativeStackAt: i) nativeRegisterMask]].
	^regsSet