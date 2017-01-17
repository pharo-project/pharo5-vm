inline primitive generators generated code
genLowcodeEffectiveAddress64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| base index indexLow indexHigh scaleHigh offsetLow scaleLow offset offsetHigh result scale |

	(offset := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(offset := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(scale := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: offset))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (scale := Arg1Reg)].

	(index := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: offset)) bitOr: (self registerMaskFor: scale))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (index := SendNumArgsReg)].

	(base := backEnd availableRegisterOrNoneFor: (((self liveRegisters bitOr: (self registerMaskFor: offset)) bitOr: (self registerMaskFor: scale)) bitOr: (self registerMaskFor: index))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (base := ClassReg)].

	(result := backEnd availableRegisterOrNoneFor: ((((self liveRegisters bitOr: (self registerMaskFor: offset)) bitOr: (self registerMaskFor: scale)) bitOr: (self registerMaskFor: index)) bitOr: (self registerMaskFor: base))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (result := ReceiverResultReg)].
	((((offset = ReceiverResultReg or: [scale = ReceiverResultReg]) or: [index = ReceiverResultReg]) or: [base = ReceiverResultReg]) or: [result = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: offset.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: scale.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: index.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: base.
	self ssNativePop: 1.

	self abort.

	^ 0

