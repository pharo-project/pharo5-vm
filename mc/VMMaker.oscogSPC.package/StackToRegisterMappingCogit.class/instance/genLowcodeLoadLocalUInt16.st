inline primitive generators generated code
genLowcodeLoadLocalUInt16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| baseOffset value |
	baseOffset := extA.

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	value = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].

	self loadNativeLocalAddress: baseOffset to: TempReg.
	self MoveM16: 0 r: TempReg R: value.
	self ssPushNativeRegister: value.

	extA := 0.
	^ 0

