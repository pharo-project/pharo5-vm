debugging
callCogCodePopReceiver
	"This is a static version of ceCallCogCodePopReceiverReg
	 for break-pointing when debugging in C."
	<api>
	<inline: false>
	"This exists only for break-pointing."
	self cCode: [self realCECallCogCodePopReceiverReg]
		inSmalltalk: [self ceCallCogCodePopReceiverReg].
	"(and this exists only to reference Debug)"
	Debug ifFalse: [self error: 'what??']