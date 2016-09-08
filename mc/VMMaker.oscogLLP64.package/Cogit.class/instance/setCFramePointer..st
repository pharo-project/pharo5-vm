accessing
setCFramePointer: aFramePointer
	<api>
	<cmacro: '(theFP) (CFramePointer = (void *)(theFP))'>
	"and in the simulator we use..."
	^(backEnd wantsNearAddressFor: #CFramePointer)
		ifTrue: [CFramePointer := aFramePointer]
		ifFalse: [(objectMemory
					longAt: coInterpreter inMemoryCFramePointerAddress
					put: aFramePointer) asVoidPointer]