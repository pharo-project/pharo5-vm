newspeak support
nsSendCacheFromReturnAddress: mcpc
	"Caller looks like
			mov LcacheAddress, SendNumArgsReg
			call ceImplicitReceiver"
	<option: #NewspeakVM>
	<var: #mcpc type: #'char *'>
	<inline: true>
	| entryPoint cacheAddress |
	entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
	self assert: entryPoint < methodZoneBase.
	cacheAddress := (backEnd implicitReceiveCacheAt: mcpc) asUnsignedInteger.
	self assert: (objectMemory isInOldSpace: cacheAddress).
	^self cCoerceSimple: cacheAddress to: #'NSSendCache *'
