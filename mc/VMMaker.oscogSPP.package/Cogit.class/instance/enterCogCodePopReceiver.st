debugging
enterCogCodePopReceiver
	"This is a static version of ceEnterCogCodePopReceiverReg
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"This exists only for break-pointing."
	self cCode: [self realCEEnterCogCodePopReceiverReg]
		inSmalltalk: [self ceEnterCogCodePopReceiverReg].
	"(and this exists only to reference Debug)"
	Debug ifFalse: [self error: 'what??']