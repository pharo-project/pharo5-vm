inline primitive generators generated code
genLowcodeLoadInt64FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| valueHigh pointer value valueLow |
	BytesPerWord = 4 ifTrue: [

		(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(pointer := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(valueLow := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: pointer))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueLow := Arg1Reg)].

		(valueHigh := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: pointer)) bitOr: (self registerMaskFor: valueLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueHigh := SendNumArgsReg)].
		((pointer = ReceiverResultReg or: [valueLow = ReceiverResultReg]) or: [valueHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: pointer.
		self ssNativePop: 1.

		"TODO: Check the endianness"
		self MoveM32: 0 r: pointer R: valueLow.
		self MoveM32: 4 r: pointer R: valueHigh.
		self ssPushNativeRegister: valueLow secondRegister: valueHigh.

	] ifFalse: [

		(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(pointer := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(value := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: pointer))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (value := Arg1Reg)].
		(pointer = ReceiverResultReg or: [value = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: pointer.
		self ssNativePop: 1.

		self MoveM64: 0 r: pointer R: value.
		self ssPushNativeRegister: value.

	].
	^ 0

