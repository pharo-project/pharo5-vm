accessing
setCStackPointer: aStackPointer
	<api>
	<cmacro: '(theSP) (CStackPointer = (void *)(theSP))'>
	"and in the simulator we use..."
	^(backEnd wantsNearAddressFor: #CStackPointer)
		ifTrue: [CStackPointer := aStackPointer]
		ifFalse: [(objectMemory
					longAt: coInterpreter inMemoryCStackPointerAddress
					put: aStackPointer) asVoidPointer]