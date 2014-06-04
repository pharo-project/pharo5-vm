simulation stack
ssFlushUpThroughTemporaryVariable: tempIndex
	"Any occurrences on the stack of the value being stored (which is the top of stack)
	 must be flushed, and hence any values colder than them stack."
	<var: #desc type: #'CogSimStackEntry *'>
	simStackPtr - 1 to: simSpillBase by: -1 do:
		[:index| | desc |
		desc := self simStackAt: index.
		(desc type = SSBaseOffset
		 and: [desc register = FPReg
		 and: [desc offset = (self frameOffsetOfTemporary: tempIndex)]]) ifTrue:
			[self ssFlushTo: index.
			 ^self]]