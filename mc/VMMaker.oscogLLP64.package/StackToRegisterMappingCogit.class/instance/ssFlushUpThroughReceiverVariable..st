simulation stack
ssFlushUpThroughReceiverVariable: slotIndex
	"Any occurrences on the stack of the value being stored (which is the top of stack)
	 must be flushed, and hence any values colder than them stack."
	<var: #desc type: #'CogSimStackEntry *'>
	LowcodeVM ifTrue: [ self ssNativeFlushTo: simNativeStackPtr. ].
	self ssFlushUpThrough: 
		[ :desc |  
			desc type = SSBaseOffset
			 and: [desc register = ReceiverResultReg
			 and: [desc offset = (objectRepresentation slotOffsetOfInstVarIndex: slotIndex) ] ] ]