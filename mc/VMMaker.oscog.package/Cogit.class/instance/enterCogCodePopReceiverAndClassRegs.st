debugging
enterCogCodePopReceiverAndClassRegs
	"This is a static version of ceEnterCogCodePopReceiverAndClassRegs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"This exists only for break-pointing."
	self cCode: [self realCEEnterCogCodePopReceiverAndClassRegs]
		inSmalltalk: [self ceEnterCogCodePopReceiverAndClassRegs]