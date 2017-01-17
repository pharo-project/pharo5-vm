inline primitive generators generated code
genLowcodeMovePointerToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID pointerValue |
	registerID := extA.

	(pointerValue := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointerValue := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointerValue = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointerValue.
	self ssNativePop: 1.

	self abort.

	extA := 0.
	^ 0

