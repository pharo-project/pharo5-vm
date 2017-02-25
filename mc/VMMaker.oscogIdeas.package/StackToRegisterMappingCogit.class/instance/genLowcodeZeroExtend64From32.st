inline primitive generators generated code
genLowcodeZeroExtend64From32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| resultLow resultHigh value result |
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
		self MoveCq: 0 R: resultHigh.
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

		self ZeroExtend32R: value R: value.
		self ssPushNativeRegister: value.

	].
	^ 0

