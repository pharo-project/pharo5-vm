inline primitive generators generated code
genLowcodeMalloc64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| sizeHigh size sizeLow pointer |
	BytesPerWord = 4 ifTrue: [

		(sizeLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(sizeLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(sizeHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: sizeLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (sizeHigh := Arg1Reg)].

		(pointer := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: sizeLow)) bitOr: (self registerMaskFor: sizeHigh))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (pointer := SendNumArgsReg)].
		((sizeLow = ReceiverResultReg or: [sizeHigh = ReceiverResultReg]) or: [pointer = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: sizeLow secondReg: sizeHigh.
		self ssNativePop: 1.

		self ssFlushAll.
		sizeLow ~= ReceiverResultReg ifTrue: [self MoveR: sizeLow R: ReceiverResultReg ].
		self CallRT: ceMallocTrampoline.
		self MoveR: TempReg R: pointer.
		self ssPushNativeRegister: pointer.

	] ifFalse: [

		(size := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(size := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(pointer := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: size))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (pointer := Arg1Reg)].
		(size = ReceiverResultReg or: [pointer = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: size.
		self ssNativePop: 1.

		self ssFlushAll.
		size ~= ReceiverResultReg ifTrue: [self MoveR: size R: ReceiverResultReg ].
		self CallRT: ceMallocTrampoline.
		self MoveR: TempReg R: pointer.
		self ssPushNativeRegister: pointer.

	].
	^ 0

