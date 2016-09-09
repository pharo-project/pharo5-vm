inline primitive generators generated code
genLowcodeLoadArgumentInt8
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

	self loadNativeArgumentAddress: baseOffset to: TempReg.
	self MoveM8: 0 r: TempReg R: value.
	self SignExtend8R: value R: value.
	self ssPushNativeRegister: value.

	extA := 0.
	^ 0

