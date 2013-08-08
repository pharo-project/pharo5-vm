process primitive support
activeProcess
	"Answer the current activeProcess."
	^self fetchPointer: ActiveProcessIndex ofObject: self schedulerPointer