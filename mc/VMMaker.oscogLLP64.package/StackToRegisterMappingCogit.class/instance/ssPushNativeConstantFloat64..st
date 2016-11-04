simulation stack
ssPushNativeConstantFloat64: aFloat64
	<option: #LowcodeVM>
	<var: #aFloat64 type: #double>
	self ssNativePush: 1.
	simNativeSpillBase > simNativeStackPtr ifTrue:
		[simNativeSpillBase := simNativeStackPtr max: 0].
	simNativeStackSize := simNativeStackSize + 8.
	self ssNativeTop
		type: SSConstantFloat64;
		spilled: false;
		offset: simNativeStackSize;
		constantFloat64: aFloat64;
		bcptr: bytecodePC.
	^0