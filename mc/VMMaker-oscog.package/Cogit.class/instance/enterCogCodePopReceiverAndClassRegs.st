debugging
enterCogCodePopReceiverAndClassRegs
	"This is a static version of ceEnterCogCodePopReceiverAndClassRegs
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"(and this exists only to reference Debug)"
	Debug ifFalse: [self error: 'what??'].
	"This exists only for break-pointing."
	self cCode: 'realCEEnterCogCodePopReceiverAndClassRegs()'
		inSmalltalk: [self ceEnterCogCodePopReceiverAndClassRegs]