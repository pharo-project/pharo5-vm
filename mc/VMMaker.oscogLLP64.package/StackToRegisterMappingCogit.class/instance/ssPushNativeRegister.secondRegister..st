simulation stack
ssPushNativeRegister: reg secondRegister: secondReg
	<option: #LowcodeVM>
	self ssNativePush: 1.
	simNativeSpillBase > simNativeStackPtr ifTrue:
		[simNativeSpillBase := simNativeStackPtr max: 0].
	simNativeStackSize := simNativeStackSize + 8.
	self ssNativeTop
		type: SSRegisterPair;
		spilled: false;
		offset: simNativeStackSize;
		register: reg;
		registerSecond: secondReg;
		bcptr: bytecodePC.
	^0