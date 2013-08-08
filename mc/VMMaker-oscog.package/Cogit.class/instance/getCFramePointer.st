accessing
getCFramePointer
	<api>
	<cmacro: '() CFramePointer'>
	"and in the simulator we use..."
	^objectMemory longAt: coInterpreter inMemoryCFramePointerAddress