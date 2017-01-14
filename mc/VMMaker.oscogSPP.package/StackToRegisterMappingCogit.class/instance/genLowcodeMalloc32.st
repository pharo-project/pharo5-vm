inline primitive generators generated code
genLowcodeMalloc32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer size |

	(size := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(size := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(pointer := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: size))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (pointer := Arg1Reg)].
	(size = ReceiverResultReg or: [pointer = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: size.
	self ssNativePop: 1.

	self ssFlushAll.
	size ~= ReceiverResultReg ifTrue: [self MoveR: size R: ReceiverResultReg ].
	self CallRT: ceMallocTrampoline.
	self MoveR: TempReg R: pointer.
	self ssPushNativeRegister: pointer.

	^ 0

