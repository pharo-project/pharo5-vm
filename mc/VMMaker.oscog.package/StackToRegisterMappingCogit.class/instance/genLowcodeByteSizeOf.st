inline primitive generators generated code
genLowcodeByteSizeOf
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |

	(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(object := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(value := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: object))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (value := Arg1Reg)].
	(object = ReceiverResultReg or: [value = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: object.
	self ssPop: 1.

	self ssFlushAll.
	objectRepresentation genLcByteSizeOf: object to: value.

	^ 0

