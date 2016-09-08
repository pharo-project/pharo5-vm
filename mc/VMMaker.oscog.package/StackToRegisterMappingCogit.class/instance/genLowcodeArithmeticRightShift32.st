inline primitive generators generated code
genLowcodeArithmeticRightShift32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value shiftAmount |

	(shiftAmount := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(shiftAmount := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(value := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: shiftAmount))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (value := Arg1Reg)].
	(shiftAmount = ReceiverResultReg or: [value = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: shiftAmount.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self ArithmeticShiftRightR: shiftAmount R: value.
	self ssPushNativeRegister: value.

	^ 0

