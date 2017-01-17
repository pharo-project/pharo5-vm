inline primitive generators generated code
genLowcodeInstantiateIndexableOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| indexableSize object classOop |
	indexableSize := extA.

	(classOop := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(classOop := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(object := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: classOop))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (object := Arg1Reg)].
	(classOop = ReceiverResultReg or: [object = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: classOop.
	self ssPop: 1.

	self ssFlushAll.
	objectRepresentation genLcInstantiateOop: classOop constantIndexableSize: indexableSize.

	extA := 0.
	^ 0

