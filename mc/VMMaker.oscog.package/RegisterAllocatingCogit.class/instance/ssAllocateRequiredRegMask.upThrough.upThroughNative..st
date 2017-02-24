simulation stack
ssAllocateRequiredRegMask: requiredRegsMask upThrough: stackPtr upThroughNative: nativeStackPtr
	"Override to void any required registers in temp vars."
	(requiredRegsMask anyMask: (self registerMaskFor: ReceiverResultReg)) ifTrue:
		[optStatus isReceiverResultRegLive: false.
		 optStatus ssEntry liveRegister: NoReg].
	0 to: methodOrBlockNumTemps - 1 do:
		[:i|
		((self simStackAt: i) registerMask anyMask: requiredRegsMask) ifTrue:
			[(self simStackAt: i) liveRegister: 0]].
	super ssAllocateRequiredRegMask: requiredRegsMask upThrough: stackPtr upThroughNative: nativeStackPtr