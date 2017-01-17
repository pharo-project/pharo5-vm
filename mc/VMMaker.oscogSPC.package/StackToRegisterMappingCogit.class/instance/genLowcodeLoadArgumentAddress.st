inline primitive generators generated code
genLowcodeLoadArgumentAddress
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

	self loadNativeArgumentAddress: baseOffset to: pointer.
	self ssPushNativeRegister: pointer.

	extA := 0.
	^ 0

