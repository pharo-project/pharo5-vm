inline primitive generators generated code
genLowcodeFirstFieldPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object |

	(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(object := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	object = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: object.
	self ssPop: 1.

	objectRepresentation genLcFirstFieldPointer: object.

	^ 0

