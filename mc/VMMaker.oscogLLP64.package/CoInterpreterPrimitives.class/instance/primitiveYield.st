process primitives
primitiveYield
"primitively do the equivalent of Process>yield"
	| scheduler activeProc priority processLists processList inInterpreter |
	scheduler := self schedulerPointer.
	activeProc := objectMemory fetchPointer: ActiveProcessIndex ofObject: scheduler.
	priority := self quickFetchInteger: PriorityIndex ofObject: activeProc.
	processLists := objectMemory fetchPointer: ProcessListsIndex ofObject: scheduler.
	processList := objectMemory fetchPointer: priority - 1 ofObject: processLists.

	(self isEmptyList: processList) ifTrue:
		[^nil].
	"We're going to switch process, either to an interpreted frame or a machine
	 code frame. To know whether to return or enter machine code we have to
	 know from whence we came.  We could have come from the interpreter,
	 either directly or via a machine code primitive.  We could have come from
	 machine code.  The instructionPointer tells us where from:"
	inInterpreter := instructionPointer >= objectMemory startOfMemory.
	self addLastLink: activeProc toList: processList.
	self transferTo: self wakeHighestPriority from: CSYield.
	self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter