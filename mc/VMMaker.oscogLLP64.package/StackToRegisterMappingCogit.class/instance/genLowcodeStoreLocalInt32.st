inline primitive generators generated code
genLowcodeStoreLocalInt32
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

	self loadNativeLocalAddress: baseOffset to: TempReg.
	self MoveR: value M32: 0 r: TempReg.

	extA := 0.
	^ 0

