debugging
enterCogCodePopReceiverArg0Regs
	"This is a static version of ceEnterCogCodePopReceiverArg0Regs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"(and this exists only to reference Debug)"
	Debug ifFalse: [self error: 'what??'].
	"This exists only for break-pointing."
	self cCode: 'realCEEnterCogCodePopReceiverArg0Regs()'
		inSmalltalk: [self ceEnterCogCodePopReceiverArg0Regs]