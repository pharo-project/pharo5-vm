simulation stack
ssPushNativeConstantInt32: anInt32
	<option: #LowcodeVM>
	self ssNativePush: 1.
	simNativeSpillBase > simNativeStackPtr ifTrue:
		[simNativeSpillBase := simNativeStackPtr max: 0].
	simNativeStackSize := simNativeStackSize + BytesPerWord.
	self ssNativeTop
		type: SSConstantInt32;
		spilled: false;
		offset: simNativeStackSize;
		constantInt32: anInt32;
		bcptr: bytecodePC.
	^0