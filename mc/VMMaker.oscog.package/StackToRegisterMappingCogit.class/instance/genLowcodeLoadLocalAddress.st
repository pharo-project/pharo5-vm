inline primitive generators generated code
genLowcodeLoadLocalAddress
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| baseOffset pointer |
	baseOffset := extA.

	(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointer := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointer = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].

	self loadNativeLocalAddress: baseOffset to: pointer.
	self ssPushNativeRegister: pointer.

	extA := 0.
	^ 0

