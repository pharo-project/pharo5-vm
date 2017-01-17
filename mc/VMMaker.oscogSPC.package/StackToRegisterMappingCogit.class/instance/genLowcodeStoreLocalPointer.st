inline primitive generators generated code
genLowcodeStoreLocalPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerValue baseOffset |
	baseOffset := extA.

	(pointerValue := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointerValue := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointerValue = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointerValue.
	self ssNativePop: 1.

	self loadNativeLocalAddress: baseOffset to: TempReg.
	self MoveR: pointerValue Mw: 0 r: TempReg.

	extA := 0.
	^ 0

