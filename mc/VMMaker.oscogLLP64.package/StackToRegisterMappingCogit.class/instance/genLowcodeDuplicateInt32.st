inline primitive generators generated code
genLowcodeDuplicateInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value dup2 |

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(dup2 := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (dup2 := Arg1Reg)].
	(value = ReceiverResultReg or: [dup2 = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self MoveR: value R: dup2.
	self ssPushNativeRegister: value;
	ssPushNativeRegister: dup2.

	^ 0

