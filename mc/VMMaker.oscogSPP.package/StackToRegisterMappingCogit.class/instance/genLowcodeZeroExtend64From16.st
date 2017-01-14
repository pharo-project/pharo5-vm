inline primitive generators generated code
genLowcodeZeroExtend64From16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| valueHigh value valueLow |
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

		self ZeroExtend16R: valueLow R: valueLow.
		self MoveCq: 0 R: valueHigh.
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

		self ZeroExtend16R: value R: value.
		self ssPushNativeRegister: value.

	].
	^ 0

