trampoline support
genSmalltalkToCStackSwitch
	backEnd genSaveStackPointers.
	cFramePointerInUse
		ifTrue: [backEnd genLoadCStackPointers]
		ifFalse: [backEnd genLoadCStackPointer].
	^0