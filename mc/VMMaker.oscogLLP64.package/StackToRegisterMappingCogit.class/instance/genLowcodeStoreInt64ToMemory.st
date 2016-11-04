inline primitive generators generated code
genLowcodeStoreInt64ToMemory
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
		self ssNativeTop nativePopToReg: valueLow secondReg: valueHigh.
		self ssNativePop: 1.

		self MoveR: valueLow M32: 0 r: pointer.
		self MoveR: valueHigh M32: 4 r: pointer.

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
		self ssNativeTop nativePopToReg: value.
		self ssNativePop: 1.

		self MoveR: value M64: 0 r: pointer.

	].
	^ 0

