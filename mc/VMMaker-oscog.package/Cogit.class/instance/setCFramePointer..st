accessing
setCFramePointer: aFramePointer
	<api>
	<cmacro: '(theFP) (CFramePointer = (void *)(theFP))'>
	"and in the simulator we use..."
	^objectMemory
		longAt: coInterpreter inMemoryCFramePointerAddress
		put: aFramePointer