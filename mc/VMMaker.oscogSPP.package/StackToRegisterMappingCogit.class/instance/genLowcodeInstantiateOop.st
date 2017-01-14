inline primitive generators generated code
genLowcodeInstantiateOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| classOop |

	(classOop := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(classOop := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	classOop = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: classOop.
	self ssPop: 1.

	self ssFlushAll.
	objectRepresentation genLcInstantiateOop: classOop.

	^ 0

