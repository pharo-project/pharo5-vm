inline primitive generators generated code
genLowcodeSignExtend64From16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value isNegative cont valueLow valueHigh |
	BytesPerWord = 4 ifTrue: [

		(valueLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(valueLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(valueHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: valueLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueHigh := Arg1Reg)].
		(valueLow = ReceiverResultReg or: [valueHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: valueLow secondReg: valueHigh.
		self ssNativePop: 1.

		self SignExtend16R: valueLow R: valueLow.
		"Check the sign to set the high word"
		self CmpCq: 0 R: valueLow.
		"Positive"
		isNegative := self JumpLess: 0.
		self MoveCq: 0 R: valueHigh.
		cont := self Jump: 0.
		"Negative"
		isNegative jmpTarget: (self MoveCq: -1 R: valueHigh).
		cont jmpTarget: self Label.
		self ssPushNativeRegister: valueLow secondRegister: valueHigh.

	] ifFalse: [

		(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(value := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].
		value = ReceiverResultReg ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: value.
		self ssNativePop: 1.

		self SignExtend16R: value R: value.
		self ssPushNativeRegister: value.

	].
	^ 0

