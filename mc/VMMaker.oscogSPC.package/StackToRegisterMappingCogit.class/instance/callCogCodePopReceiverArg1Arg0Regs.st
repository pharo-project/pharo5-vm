debugging
callCogCodePopReceiverArg1Arg0Regs
	"This is a static version of ceCallCogCodePopReceiverArg1Arg0Regs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"This exists only for break-pointing."
	self cCode: [self realCECallCogCodePopReceiverArg1Arg0Regs]
		inSmalltalk: [self ceCallCogCodePopReceiverArg1Arg0Regs]