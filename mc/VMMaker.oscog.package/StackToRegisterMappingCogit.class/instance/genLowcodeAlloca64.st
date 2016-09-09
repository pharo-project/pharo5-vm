inline primitive generators generated code
genLowcodeAlloca64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| sizeHigh size sizeLow |
	BytesPerWord = 4 ifTrue: [

		(sizeLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(sizeLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(sizeHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: sizeLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (sizeHigh := Arg1Reg)].
		(sizeLow = ReceiverResultReg or: [sizeHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: sizeLow secondReg: sizeHigh.
		self ssNativePop: 1.

		self SubR: sizeLow R: SPReg.
		self MoveR: SPReg R: sizeLow.
		self ssPushNativeRegister: sizeLow.

	] ifFalse: [

		(size := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(size := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].
		size = ReceiverResultReg ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: size.
		self ssNativePop: 1.

		self SubR: size R: SPReg.
		self MoveR: SPReg R: size.
		self ssPushNativeRegister: size.

	].
	^ 0

