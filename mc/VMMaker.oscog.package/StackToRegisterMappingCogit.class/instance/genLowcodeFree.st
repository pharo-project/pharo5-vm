inline primitive generators generated code
genLowcodeFree
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer |

	(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointer := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointer = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointer.
	self ssNativePop: 1.

	self ssFlushAll.
	pointer ~= ReceiverResultReg ifTrue: [self MoveR: pointer R: ReceiverResultReg ].
	self CallRT: ceFreeTrampoline.

	^ 0

