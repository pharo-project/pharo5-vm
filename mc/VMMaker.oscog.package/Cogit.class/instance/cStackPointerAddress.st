trampoline support
cStackPointerAddress
	<cmacro: '() ((usqIntptr_t)&CStackPointer)'>
	^(backEnd wantsNearAddressFor: #CStackPointer)
		ifTrue: [self simulatedReadWriteVariableAddress: #getCStackPointer in: self]
		ifFalse: [coInterpreter inMemoryCStackPointerAddress]