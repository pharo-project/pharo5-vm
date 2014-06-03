simulation stack
ssFlushUpThroughReceiverVariable: slotIndex
	"Any occurrences on the stack of the value being stored (which is the top of stack)
	 must be flushed, and hence any values colder than them stack."
	<var: #desc type: #'CogSimStackEntry *'>
	simStackPtr - 1 to: (simSpillBase max: 0) by: -1 do:
		[:index| | desc |
		desc := self simStackAt: index.
		(desc type = SSBaseOffset
		 and: [desc register = ReceiverResultReg
		 and: [desc offset = (objectRepresentation slotOffsetOfInstVarIndex: slotIndex)]]) ifTrue:
			[self ssFlushTo: index.
			 ^self]]