process primitives
primitiveWait
	| sema excessSignals activeProc |
	sema := self stackTop.  "rcvr"
	excessSignals := self fetchInteger: ExcessSignalsIndex ofObject: sema.
	excessSignals > 0
		ifTrue:
			[self storeInteger: ExcessSignalsIndex ofObject: sema withValue: excessSignals - 1]
		ifFalse:
			[activeProc := self activeProcess.
			 self addLastLink: activeProc toList: sema.
			 self transferTo: self wakeHighestPriority]