trampoline support
genExternalizePointersForPrimitiveCall
	" Override to push the register receiver and register arguments, if any."
	self genPushRegisterArgs.
	^super genExternalizePointersForPrimitiveCall