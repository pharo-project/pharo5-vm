debugging
callCogCodePopReceiverAndClassRegs
	"This is a static version of ceCallCogCodePopReceiverAndClassRegs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"This exists only for break-pointing."
	self cCode: [self realCECallCogCodePopReceiverAndClassRegs]
		inSmalltalk: [self ceCallCogCodePopReceiverAndClassRegs]