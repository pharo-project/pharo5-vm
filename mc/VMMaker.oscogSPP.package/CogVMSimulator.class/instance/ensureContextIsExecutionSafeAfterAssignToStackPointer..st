frame access
ensureContextIsExecutionSafeAfterAssignToStackPointer: aContext
	"16r1934F80 = aContext ifTrue:
		[self halt]."
	^super ensureContextIsExecutionSafeAfterAssignToStackPointer: aContext