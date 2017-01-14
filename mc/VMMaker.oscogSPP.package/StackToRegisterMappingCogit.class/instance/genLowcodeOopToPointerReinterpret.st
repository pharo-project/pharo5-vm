inline primitive generators generated code
genLowcodeOopToPointerReinterpret
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object pointer |

	(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(object := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(pointer := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: object))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (pointer := Arg1Reg)].
	(object = ReceiverResultReg or: [pointer = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: object.
	self ssPop: 1.

	"TODO: Generate a nop here"
	self ssPushNativeRegister: object.

	^ 0

