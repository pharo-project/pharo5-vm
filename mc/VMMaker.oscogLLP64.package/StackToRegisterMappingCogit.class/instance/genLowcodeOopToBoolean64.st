inline primitive generators generated code
genLowcodeOopToBoolean64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| valueHigh object value valueLow |
	BytesPerWord = 4 ifTrue: [

		(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(object := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(valueLow := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: object))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueLow := Arg1Reg)].

		(valueHigh := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: object)) bitOr: (self registerMaskFor: valueLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (valueHigh := SendNumArgsReg)].
		((object = ReceiverResultReg or: [valueLow = ReceiverResultReg]) or: [valueHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssTop popToReg: object.
		self ssPop: 1.

		self MoveCq: 0 R: valueHigh.
		self annotate: (self SubCw: objectMemory falseObject R: object) objRef: objectMemory falseObject.
		self ssPushNativeRegister: object secondRegister: valueHigh.

	] ifFalse: [

		(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(object := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(value := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: object))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (value := Arg1Reg)].
		(object = ReceiverResultReg or: [value = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssTop popToReg: object.
		self ssPop: 1.

		self annotate: (self SubCw: objectMemory falseObject R: object) objRef: objectMemory falseObject.
		self ssPushNativeRegister: object.

	].
	^ 0

