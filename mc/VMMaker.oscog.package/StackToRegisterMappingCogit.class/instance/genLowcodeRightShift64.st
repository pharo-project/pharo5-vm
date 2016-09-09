inline primitive generators generated code
genLowcodeRightShift64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result shiftAmount shiftAmountHigh resultLow valueLow resultHigh shiftAmountLow valueHigh |

	(shiftAmount := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(shiftAmount := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(value := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: shiftAmount))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (value := Arg1Reg)].

	(result := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: shiftAmount)) bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (result := SendNumArgsReg)].
	((shiftAmount = ReceiverResultReg or: [value = ReceiverResultReg]) or: [result = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: shiftAmount.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self abort.

	^ 0

