simulation stack
ssPushNativeConstantPointer: aNativePointer
	<option: #LowcodeVM>
	self ssNativePush: 1.
	simNativeSpillBase > simNativeStackPtr ifTrue:
		[simNativeSpillBase := simNativeStackPtr max: 0].
	simNativeStackSize := simNativeStackSize + BytesPerWord.
	self ssNativeTop
		type: SSConstantNativePointer;
		spilled: false;
		offset: simNativeStackSize;
		constantNativePointer: aNativePointer;
		bcptr: bytecodePC.
	^0