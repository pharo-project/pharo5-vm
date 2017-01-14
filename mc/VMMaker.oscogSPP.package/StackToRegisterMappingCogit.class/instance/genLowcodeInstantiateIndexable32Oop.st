inline primitive generators generated code
genLowcodeInstantiateIndexable32Oop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| indexableSize object classOop |

	(indexableSize := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(indexableSize := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(classOop := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: indexableSize))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (classOop := Arg1Reg)].

	(object := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: indexableSize)) bitOr: (self registerMaskFor: classOop))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (object := SendNumArgsReg)].
	((indexableSize = ReceiverResultReg or: [classOop = ReceiverResultReg]) or: [object = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: indexableSize.
	self ssNativePop: 1.
	self ssTop popToReg: classOop.
	self ssPop: 1.

	self ssFlushAll.
	objectRepresentation genLcInstantiateOop: classOop indexableSize: indexableSize.

	^ 0

