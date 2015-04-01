newspeak support
implicitReceiverCacheAddressAt: mcpc
	"Caller looks like
		mov LcacheAddress, SendNumArgsReg
		call ceImplicitReceiver"
	<option: #NewspeakVM>
	<var: #mcpc type: #'char *'>
	<inline: true>
	self assert: false.
	^self cCoerceSimple: (backEnd implicitReceiveCacheAt: mcpc) asUnsignedInteger to: #'NSSendCache *'
