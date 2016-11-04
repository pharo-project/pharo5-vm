inline primitive generators generated code
genLowcodePointerToInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| resultLow pointer result resultHigh |
	BytesPerWord = 4 ifTrue: [

		(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(pointer := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(resultLow := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: pointer))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (resultLow := Arg1Reg)].

		(resultHigh := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: pointer)) bitOr: (self registerMaskFor: resultLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (resultHigh := SendNumArgsReg)].
		((pointer = ReceiverResultReg or: [resultLow = ReceiverResultReg]) or: [resultHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: pointer.
		self ssNativePop: 1.

		self MoveR: pointer R: resultLow.
		self MoveCq: 0 R: resultHigh.
		self ssPushNativeRegister: resultLow secondRegister: resultHigh.

	] ifFalse: [

		(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(pointer := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(result := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: pointer))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (result := Arg1Reg)].
		(pointer = ReceiverResultReg or: [result = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: pointer.
		self ssNativePop: 1.

		self ssPushNativeRegister: pointer.

	].
	^ 0

