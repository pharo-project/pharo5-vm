inline primitive generators generated code
genLowcodeLoadObjectField
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object |
	fieldIndex := extA.

	(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(object := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	object = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: object.
	self ssPop: 1.

	objectRepresentation genLcLoadObject: object field: fieldIndex.

	extA := 0.
	^ 0

