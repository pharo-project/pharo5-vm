debugging
enterCogCodePopReceiver
	"This is a static version of ceEnterCogCodePopReceiverReg
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"(and this exists only to reference Debug)"
	Debug ifFalse: [self error: 'what??'].
	"This exists only for break-pointing."
	self cCode: 'realCEEnterCogCodePopReceiverReg()'
		inSmalltalk: [self ceEnterCogCodePopReceiverReg]