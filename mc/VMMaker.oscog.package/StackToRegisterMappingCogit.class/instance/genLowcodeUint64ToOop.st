inline primitive generators generated code
genLowcodeUint64ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| valueHigh object value valueLow |
	BytesPerWord = 4 ifTrue: [

		(valueLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(valueLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(valueHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: valueLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueHigh := Arg1Reg)].

		(object := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: valueLow)) bitOr: (self registerMaskFor: valueHigh))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (object := SendNumArgsReg)].
		((valueLow = ReceiverResultReg or: [valueHigh = ReceiverResultReg]) or: [object = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: valueLow secondReg: valueHigh.
		self ssNativePop: 1.

		self ssFlushAll.
		objectRepresentation genLcUInt64ToOop: valueLow highPart: valueHigh.

	] ifFalse: [

		(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(value := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(object := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (object := Arg1Reg)].
		(value = ReceiverResultReg or: [object = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: value.
		self ssNativePop: 1.

		self ssFlushAll.
		objectRepresentation genLcUInt64ToOop: value.

	].
	^ 0

