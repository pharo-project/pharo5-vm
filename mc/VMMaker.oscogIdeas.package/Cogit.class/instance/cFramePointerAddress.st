trampoline support
cFramePointerAddress
	<cmacro: '() ((usqIntptr_t)&CFramePointer)'>
	^(backEnd wantsNearAddressFor: #CFramePointer)
		ifTrue: [self simulatedReadWriteVariableAddress: #getCFramePointer in: self]
		ifFalse: [coInterpreter inMemoryCFramePointerAddress]