simulation stack
ssPushNativeConstantFloat32: aFloat32
	<option: #LowcodeVM>
	<var: #aFloat32 type: #float>
	self ssNativePush: 1.
	simNativeSpillBase > simNativeStackPtr ifTrue:
		[simNativeSpillBase := simNativeStackPtr max: 0].
	simNativeStackSize := simNativeStackSize + BytesPerWord.
	self ssNativeTop
		type: SSConstantFloat32;
		spilled: false;
		offset: simNativeStackSize;
		constantFloat32: aFloat32;
		bcptr: bytecodePC.
	^0