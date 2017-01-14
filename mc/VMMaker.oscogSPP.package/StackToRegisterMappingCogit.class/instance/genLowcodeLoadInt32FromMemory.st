inline primitive generators generated code
genLowcodeLoadInt32FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |

	(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointer := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(value := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: pointer))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (value := Arg1Reg)].
	(pointer = ReceiverResultReg or: [value = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointer.
	self ssNativePop: 1.

	self MoveM32: 0 r: pointer R: value.
	self ssPushNativeRegister: value.

	^ 0

