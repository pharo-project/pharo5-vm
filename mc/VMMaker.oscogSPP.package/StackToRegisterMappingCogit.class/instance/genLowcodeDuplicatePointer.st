inline primitive generators generated code
genLowcodeDuplicatePointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| dup2 pointerValue |

	(pointerValue := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointerValue := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(dup2 := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: pointerValue))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (dup2 := Arg1Reg)].
	(pointerValue = ReceiverResultReg or: [dup2 = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointerValue.
	self ssNativePop: 1.

	self MoveR: pointerValue R: dup2.
	self ssPushNativeRegister: pointerValue;
	ssPushNativeRegister: dup2.

	^ 0

