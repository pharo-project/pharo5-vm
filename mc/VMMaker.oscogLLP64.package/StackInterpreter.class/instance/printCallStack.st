debug printing
printCallStack
	<inline: false>
	framePointer = nil
		ifTrue: [self printCallStackOf: (objectMemory fetchPointer: SuspendedContextIndex ofObject: self activeProcess)]
		ifFalse: [self printCallStackFP: framePointer]