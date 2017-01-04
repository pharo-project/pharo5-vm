frame access
externalSetStackPageAndPointersForSuspendedContextOfProcess: aProcess
	"Override to check stack depth (hence in the simulator only)."
	super externalSetStackPageAndPointersForSuspendedContextOfProcess:  aProcess.
	(self isMachineCodeFrame: framePointer) ifTrue:
		[self maybeCheckStackDepth: 0
			sp: stackPointer
			pc: instructionPointer]