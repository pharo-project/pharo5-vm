inline primitive generators generated code
genLowcodeStoreLocalInt16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	baseOffset := extA.

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	value = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self MoveR: value R: TempReg.
	self loadNativeLocalAddress: baseOffset to: value.
	self MoveR: TempReg M16: 0 r: value.

	extA := 0.
	^ 0

