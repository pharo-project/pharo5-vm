debugging
callCogCodePopReceiverArg0Regs
	"This is a static version of ceCallCogCodePopReceiverArg0Regs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"This exists only for break-pointing."
	self cCode: [self realCECallCogCodePopReceiverArg0Regs]
		inSmalltalk: [self ceCallCogCodePopReceiverArg0Regs]