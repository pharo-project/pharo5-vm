newspeak support
voidImplicitReceiverCacheAt: mcpc
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
	| cacheAddress |
	self assert: NumOopsPerIRC = 2.
	cacheAddress := self implicitReceiverCacheAddressAt: mcpc.
	backEnd
		unalignedLongAt: cacheAddress put: 0;
		unalignedLongAt: cacheAddress + BytesPerOop put: 0