inline primitive generators generated code
genLowcodeMoveInt32ToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	registerID := extA.

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	value = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self abort.

	extA := 0.
	^ 0

