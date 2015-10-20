accessing
setCStackPointer: aStackPointer
	<api>
	<cmacro: '(theSP) (CStackPointer = (void *)(theSP))'>
	"and in the simulator we use..."
	^(backEnd wantsNearAddressFor: #CStackPointer)
		ifTrue: [CStackPointer]
		ifFalse: [objectMemory
					longAt: coInterpreter inMemoryCStackPointerAddress
					put: aStackPointer]