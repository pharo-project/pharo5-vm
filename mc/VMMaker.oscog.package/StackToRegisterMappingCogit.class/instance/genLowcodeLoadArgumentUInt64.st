inline primitive generators generated code
genLowcodeLoadArgumentUInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| baseOffset value valueLow valueHigh |
	baseOffset := extA.
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

		"TODO: Check the endianness"
		self loadNativeArgumentAddress: baseOffset to: TempReg.
		self MoveM32: 0 r: TempReg R: valueLow.
		self MoveM32: 4 r: TempReg R: valueHigh.
		self ssPushNativeRegister: valueLow secondRegister: valueHigh.

	] ifFalse: [

		(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(value := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].
		value = ReceiverResultReg ifTrue:
			[ optStatus isReceiverResultRegLive: false ].

		self loadNativeArgumentAddress: baseOffset to: TempReg.
		self MoveM64: 0 r: TempReg R: value.
		self ssPushNativeRegister: value.

	].
		extA := 0.
	^ 0

