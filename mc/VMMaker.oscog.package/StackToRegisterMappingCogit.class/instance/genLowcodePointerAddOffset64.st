inline primitive generators generated code
genLowcodePointerAddOffset64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| offsetHigh base offset offsetLow |
	BytesPerWord = 4 ifTrue: [

		(offsetLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(offsetLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(offsetHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: offsetLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (offsetHigh := Arg1Reg)].

		(base := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: offsetLow)) bitOr: (self registerMaskFor: offsetHigh))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (base := SendNumArgsReg)].
		((offsetLow = ReceiverResultReg or: [offsetHigh = ReceiverResultReg]) or: [base = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: offsetLow secondReg: offsetHigh.
		self ssNativePop: 1.
		self ssNativeTop nativePopToReg: base.
		self ssNativePop: 1.

		self AddR: offsetLow R: base.
		self ssPushNativeRegister: base.

	] ifFalse: [

		(offset := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(offset := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(base := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: offset))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (base := Arg1Reg)].
		(offset = ReceiverResultReg or: [base = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: offset.
		self ssNativePop: 1.
		self ssNativeTop nativePopToReg: base.
		self ssNativePop: 1.

		self AddR: offset R: base.
		self ssPushNativeRegister: base.

	].
	^ 0

