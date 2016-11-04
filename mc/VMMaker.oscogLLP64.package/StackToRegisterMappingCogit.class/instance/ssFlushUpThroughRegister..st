simulation stack
ssFlushUpThroughRegister: reg
	"Any occurrences on the stack of the register must be
	 flushed, and hence any values colder than them stack."
	<var: #desc type: #'CogSimStackEntry *'>
	LowcodeVM ifTrue: [ self ssNativeFlushTo: simNativeStackPtr ].
	self ssFlushUpThrough: [ :desc | desc type = SSRegister and: [ desc register = reg ] ]