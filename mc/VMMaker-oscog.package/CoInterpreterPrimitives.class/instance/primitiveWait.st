process primitives
primitiveWait
	| sema excessSignals activeProc inInterpreter |
	sema := self stackTop.  "rcvr"
	excessSignals := self fetchInteger: ExcessSignalsIndex ofObject: sema.
	excessSignals > 0
		ifTrue:
			[self storeInteger: ExcessSignalsIndex
				ofObject: sema
				withValue: excessSignals - 1]
		ifFalse:
			["We're going to switch process, either to an interpreted frame or a machine
			  code frame. To know whether to return or enter machine code we have to
			  know from whence we came.  We could have come from the interpreter,
			  either directly or via a machine code primitive.  We could have come from
			  machine code.  The instructionPointer tells us where from:"
			inInterpreter := instructionPointer >= objectMemory startOfMemory.
			activeProc := self activeProcess.
			self addLastLink: activeProc toList: sema.
			self transferTo: self wakeHighestPriority from: CSWait.
			self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter]