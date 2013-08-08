accessing
setCStackPointer: aStackPointer
	<api>
	<cmacro: '(theSP) (CStackPointer = (void *)(theSP))'>
	"and in the simulator we use..."
	^objectMemory
		longAt: coInterpreter inMemoryCStackPointerAddress
		put: aStackPointer