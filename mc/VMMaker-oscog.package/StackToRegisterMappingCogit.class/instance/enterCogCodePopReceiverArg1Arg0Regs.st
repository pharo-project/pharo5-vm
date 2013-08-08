debugging
enterCogCodePopReceiverArg1Arg0Regs
	"This is a static version of ceEnterCogCodePopReceiverArg1Arg0Regs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"(and this exists only to reference Debug)"
	Debug ifFalse: [self error: 'what??'].
	"This exists only for break-pointing."
	self cCode: 'realCEEnterCogCodePopReceiverArg1Arg0Regs()'
		inSmalltalk: [self ceEnterCogCodePopReceiverArg1Arg0Regs]