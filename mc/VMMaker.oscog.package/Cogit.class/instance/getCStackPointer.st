accessing
getCStackPointer
	<api>
	<cmacro: '() CStackPointer'>
	"and in the simulator we use..."
	^(backEnd wantsNearAddressFor: #CStackPointer)
		ifTrue: [CStackPointer]
		ifFalse: [(objectMemory longAt: coInterpreter inMemoryCStackPointerAddress) asVoidPointer]