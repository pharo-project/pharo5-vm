inline primitive generators generated code
genLowcodeMul64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| secondLow firstLow secondHigh result resultLow resultHigh first second firstHigh |

	(second := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(second := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(first := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: second))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (first := Arg1Reg)].

	(result := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: second)) bitOr: (self registerMaskFor: first))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (result := SendNumArgsReg)].
	((second = ReceiverResultReg or: [first = ReceiverResultReg]) or: [result = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: second.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: first.
	self ssNativePop: 1.

	self abort.

	^ 0

