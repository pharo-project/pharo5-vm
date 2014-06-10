debugging
enterCogCodePopReceiverArg0Regs
	"This is a static version of ceEnterCogCodePopReceiverArg0Regs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"This exists only for break-pointing."
	self cCode: [self realCEEnterCogCodePopReceiverArg0Regs]
		inSmalltalk: [self ceEnterCogCodePopReceiverArg0Regs]