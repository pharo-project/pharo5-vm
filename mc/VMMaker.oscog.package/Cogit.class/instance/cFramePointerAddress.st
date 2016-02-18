trampoline support
cFramePointerAddress
	<cmacro: '() ((unsigned long)&CFramePointer)'>
	^(backEnd wantsNearAddressFor: #CFramePointer)
		ifTrue: [self simulatedReadWriteVariableAddress: #getCFramePointer in: self]
		ifFalse: [coInterpreter inMemoryCFramePointerAddress]