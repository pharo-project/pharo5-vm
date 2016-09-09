inline primitive generators generated code
genLowcodeSignExtend64From32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result resultLow resultHigh isNegative cont |
	BytesPerWord = 4 ifTrue: [

		(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(value := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(resultLow := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (resultLow := Arg1Reg)].

		(resultHigh := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: value)) bitOr: (self registerMaskFor: resultLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (resultHigh := SendNumArgsReg)].
		((value = ReceiverResultReg or: [resultLow = ReceiverResultReg]) or: [resultHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: value.
		self ssNativePop: 1.

		self MoveR: value R: resultLow.
		"Check the sign to set the high word"
		self CmpCq: 0 R: value.
		"Positive"
		isNegative := self JumpLess: 0.
		self MoveCq: 0 R: resultHigh.
		cont := self Jump: 0.
		"Negative"
		isNegative jmpTarget: (self MoveCq: -1 R: resultHigh).
		cont jmpTarget: self Label.
		self ssPushNativeRegister: resultLow secondRegister: resultHigh.

	] ifFalse: [

		(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(value := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(result := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (result := Arg1Reg)].
		(value = ReceiverResultReg or: [result = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: value.
		self ssNativePop: 1.

		self SignExtend32R: value R: value.
		self ssPushNativeRegister: value.

	].
	^ 0

