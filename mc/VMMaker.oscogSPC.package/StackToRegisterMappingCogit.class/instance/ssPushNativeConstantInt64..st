simulation stack
ssPushNativeConstantInt64: anInt64
	<option: #LowcodeVM>
	<var: #anInt64 type: #sqLong>
	self ssNativePush: 1.
	simNativeSpillBase > simNativeStackPtr ifTrue:
		[simNativeSpillBase := simNativeStackPtr max: 0].
	simNativeStackSize := simNativeStackSize + 8.
	self ssNativeTop
		type: SSConstantInt64;
		spilled: false;
		offset: simNativeStackSize;
		constantInt64: anInt64;
		bcptr: bytecodePC.
	^0