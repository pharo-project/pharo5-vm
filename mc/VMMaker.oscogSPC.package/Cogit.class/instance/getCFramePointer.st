accessing
getCFramePointer
	<api>
	<cmacro: '() CFramePointer'>
	"and in the simulator we use..."
	^(backEnd wantsNearAddressFor: #CFramePointer)
		ifTrue: [CFramePointer]
		ifFalse: [(objectMemory longAt: coInterpreter inMemoryCFramePointerAddress) asVoidPointer]