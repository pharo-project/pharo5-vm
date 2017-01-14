debugging traps
primitiveClosureValueWithArgs
	"Transcript clear.
	 self shortPrintFrameAndCallers: framePointer.
	 self halt."
	^super primitiveClosureValueWithArgs