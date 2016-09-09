inline primitive generators generated code
genLowcodeAnd64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| secondLow firstLow secondHigh first second firstHigh |
	BytesPerWord = 4 ifTrue: [

		(secondLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(secondLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(secondHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: secondLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (secondHigh := Arg1Reg)].

		(firstLow := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: secondLow)) bitOr: (self registerMaskFor: secondHigh))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (firstLow := SendNumArgsReg)].

		(firstHigh := backEnd availableRegisterOrNoneFor: (((self liveRegisters bitOr: (self registerMaskFor: secondLow)) bitOr: (self registerMaskFor: secondHigh)) bitOr: (self registerMaskFor: firstLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (firstHigh := ClassReg)].
		(((secondLow = ReceiverResultReg or: [secondHigh = ReceiverResultReg]) or: [firstLow = ReceiverResultReg]) or: [firstHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: secondLow secondReg: secondHigh.
		self ssNativePop: 1.
		self ssNativeTop nativePopToReg: firstLow secondReg: firstHigh.
		self ssNativePop: 1.

		self AndR: secondLow R: firstLow.
		self AndR: secondHigh R: firstHigh.
		self ssPushNativeRegister: firstLow secondRegister: firstHigh.

	] ifFalse: [

		(second := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(second := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(first := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: second))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (first := Arg1Reg)].
		(second = ReceiverResultReg or: [first = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: second.
		self ssNativePop: 1.
		self ssNativeTop nativePopToReg: first.
		self ssNativePop: 1.

		self AndR: second R: first.
		self ssPushNativeRegister: first.

	].
	^ 0

