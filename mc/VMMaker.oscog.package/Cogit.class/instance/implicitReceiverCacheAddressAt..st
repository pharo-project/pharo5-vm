newspeak support
implicitReceiverCacheAddressAt: mcpc
	"Cached push implicit receiver implementation.  If objectRepresentation doesn't support
	 pinning then caller looks like
				mov selector, SendNumArgsReg
				call ceImplicitReceiver
				br continue
		Lclass:	.word
		Lmixin::	.word
		continue:
	 If objectRepresentation supports pinning then caller looks like
				mov Lclass, Arg1Reg
				mov selector, SendNumArgsReg
				call ceImplicitReceiver
	 and Lclass: .word; Lmixin: .word is somewhere on the heap."
	<option: #NewspeakVM>
	<var: #mcpc type: #'char *'>
	<inline: true>
	<returnTypeC: #usqInt>
	^objectRepresentation canPinObjects
		ifTrue:
			[(backEnd implicitReceiveCacheAt: mcpc) asUnsignedInteger]
		ifFalse:
			[mcpc asUnsignedInteger + backEnd jumpShortByteSize]