trampoline support
cStackPointerAddress
	<cmacro: '() ((unsigned long)&CStackPointer)'>
	^(backEnd wantsNearAddressFor: #CStackPointer)
		ifTrue: [self simulatedReadWriteVariableAddress: #getCStackPointer in: self]
		ifFalse: [coInterpreter inMemoryCStackPointerAddress]