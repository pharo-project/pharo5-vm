inline primitive generators generated code
genLowcodeDuplicateInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value dup2Low dup2 valueLow dup2High valueHigh |
	BytesPerWord = 4 ifTrue: [

		(valueLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(valueLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(valueHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: valueLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueHigh := Arg1Reg)].

		(dup2Low := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: valueLow)) bitOr: (self registerMaskFor: valueHigh))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (dup2Low := SendNumArgsReg)].

		(dup2High := backEnd availableRegisterOrNoneFor: (((self liveRegisters bitOr: (self registerMaskFor: valueLow)) bitOr: (self registerMaskFor: valueHigh)) bitOr: (self registerMaskFor: dup2Low))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (dup2High := ClassReg)].
		(((valueLow = ReceiverResultReg or: [valueHigh = ReceiverResultReg]) or: [dup2Low = ReceiverResultReg]) or: [dup2High = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: valueLow secondReg: valueHigh.
		self ssNativePop: 1.

		self MoveR: valueLow R: dup2Low.
		self MoveR: valueHigh R: dup2High.
		self ssPushNativeRegister: valueLow secondRegister: valueHigh.
		self ssPushNativeRegister: dup2Low secondRegister: dup2High.

	] ifFalse: [

		(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(value := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(dup2 := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (dup2 := Arg1Reg)].
		(value = ReceiverResultReg or: [dup2 = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: value.
		self ssNativePop: 1.

		self MoveR: value R: dup2.
		self ssPushNativeRegister: value.
		self ssPushNativeRegister: dup2.

	].
	^ 0

