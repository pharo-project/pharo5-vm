simulation stack
ssPushNativeRegisterDoubleFloat: reg
	<option: #LowcodeVM>
	self ssNativePush: 1.
	simNativeSpillBase > simNativeStackPtr ifTrue:
		[simNativeSpillBase := simNativeStackPtr max: 0].
	simNativeStackSize := simNativeStackSize + 8.
	self ssNativeTop
		type: SSRegisterDoubleFloat;
		spilled: false;
		offset: simNativeStackSize;
		register: reg;
		bcptr: bytecodePC.
	^0