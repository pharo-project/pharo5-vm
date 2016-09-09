inline primitive generators generated code
genLowcodeEffectiveAddress32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| offset base index scale |

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
	(((offset = ReceiverResultReg or: [scale = ReceiverResultReg]) or: [index = ReceiverResultReg]) or: [base = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: offset.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: scale.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: index.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: base.
	self ssNativePop: 1.

	self MulR: scale R: index.
	self AddR: index R: base.
	self AddR: offset R: base.
	self ssPushNativeRegister: base.

	^ 0

