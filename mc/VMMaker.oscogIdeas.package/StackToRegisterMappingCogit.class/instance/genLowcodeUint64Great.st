inline primitive generators generated code
genLowcodeUint64Great
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| secondLow firstLow secondHigh value first second firstHigh |

	(second := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(second := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(first := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: second))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (first := Arg1Reg)].

	(value := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: second)) bitOr: (self registerMaskFor: first))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (value := SendNumArgsReg)].
	((second = ReceiverResultReg or: [first = ReceiverResultReg]) or: [value = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: second.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: first.
	self ssNativePop: 1.

	self abort.

	^ 0

