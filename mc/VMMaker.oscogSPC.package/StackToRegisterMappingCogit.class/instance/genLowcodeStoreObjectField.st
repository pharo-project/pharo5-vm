inline primitive generators generated code
genLowcodeStoreObjectField
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object value |
	fieldIndex := extA.

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(object := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (object := Arg1Reg)].
	(value = ReceiverResultReg or: [object = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: value.
	self ssPop: 1.
	self ssTop popToReg: object.
	self ssPop: 1.

	objectRepresentation genLcStore: value object: object field: fieldIndex.

	extA := 0.
	^ 0

