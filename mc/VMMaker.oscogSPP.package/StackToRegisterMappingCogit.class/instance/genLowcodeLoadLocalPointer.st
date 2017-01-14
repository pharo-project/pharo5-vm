inline primitive generators generated code
genLowcodeLoadLocalPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| baseOffset pointerResult |
	baseOffset := extA.

	(pointerResult := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointerResult := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointerResult = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].

	self loadNativeLocalAddress: baseOffset to: TempReg.
	self MoveMw: 0 r: TempReg R: pointerResult.
	self ssPushNativeRegister: pointerResult.

	extA := 0.
	^ 0

