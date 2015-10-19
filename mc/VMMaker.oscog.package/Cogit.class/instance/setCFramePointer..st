accessing
setCFramePointer: aFramePointer
	<api>
	<cmacro: '(theFP) (CFramePointer = (void *)(theFP))'>
	"and in the simulator we use..."
	^(backEnd wantsNearAddressFor: #CFramePointer)
		ifTrue: [CFramePointer]
		ifFalse: [objectMemory
					longAt: coInterpreter inMemoryCFramePointerAddress
					put: aFramePointer]