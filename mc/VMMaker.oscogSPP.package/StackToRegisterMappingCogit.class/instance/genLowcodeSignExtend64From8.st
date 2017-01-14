inline primitive generators generated code
genLowcodeSignExtend64From8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result resultLow resultHigh isNegative valueLow cont valueHigh |
	BytesPerWord = 4 ifTrue: [

		(valueLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(valueLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(valueHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: valueLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueHigh := Arg1Reg)].

		(resultLow := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: valueLow)) bitOr: (self registerMaskFor: valueHigh))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (resultLow := SendNumArgsReg)].

		(resultHigh := backEnd availableRegisterOrNoneFor: (((self liveRegisters bitOr: (self registerMaskFor: valueLow)) bitOr: (self registerMaskFor: valueHigh)) bitOr: (self registerMaskFor: resultLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (resultHigh := ClassReg)].
		(((valueLow = ReceiverResultReg or: [valueHigh = ReceiverResultReg]) or: [resultLow = ReceiverResultReg]) or: [resultHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: valueLow secondReg: valueHigh.
		self ssNativePop: 1.

		self SignExtend8R: valueLow R: valueLow.
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

		(result := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (result := Arg1Reg)].
		(value = ReceiverResultReg or: [result = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: value.
		self ssNativePop: 1.

		self ZeroExtend16R: value R: value.
		self ssPushNativeRegister: value.

	].
	^ 0

