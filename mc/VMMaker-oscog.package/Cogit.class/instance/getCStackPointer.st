accessing
getCStackPointer
	<api>
	<cmacro: '() CStackPointer'>
	"and in the simulator we use..."
	^objectMemory longAt: coInterpreter inMemoryCStackPointerAddress