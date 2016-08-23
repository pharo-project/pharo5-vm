process primitive support
activeProcess
	"Answer the current activeProcess."
	<api> "useful for VM debugging"
	^objectMemory fetchPointer: ActiveProcessIndex ofObject: self schedulerPointer