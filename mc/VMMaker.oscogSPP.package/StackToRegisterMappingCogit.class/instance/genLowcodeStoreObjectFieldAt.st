inline primitive generators generated code
genLowcodeStoreObjectFieldAt
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object value |

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(fieldIndex := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (fieldIndex := Arg1Reg)].

	(object := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: value)) bitOr: (self registerMaskFor: fieldIndex))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (object := SendNumArgsReg)].
	((value = ReceiverResultReg or: [fieldIndex = ReceiverResultReg]) or: [object = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: value.
	self ssPop: 1.
	self ssNativeTop nativePopToReg: fieldIndex.
	self ssNativePop: 1.
	self ssTop popToReg: object.
	self ssPop: 1.

	objectRepresentation genLcStore: value object: object at: fieldIndex.

	^ 0

