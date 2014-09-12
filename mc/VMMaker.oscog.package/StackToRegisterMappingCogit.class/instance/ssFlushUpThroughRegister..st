simulation stack
ssFlushUpThroughRegister: reg
	"Any occurrences on the stack of the register must be
	 flushed, and hence any values colder than them stack."
	<var: #desc type: #'CogSimStackEntry *'>
	simStackPtr - 1 to: (simSpillBase max: 0) by: -1 do:
		[:index| | desc |
		desc := self simStackAt: index.
		(desc type = SSRegister
		 and: [desc register = reg]) ifTrue:
			[self ssFlushTo: index.
			 ^self]]