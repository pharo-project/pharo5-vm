inline primitive generators generated code
genLowcodeLoadObjectAt
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object |

	(fieldIndex := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(fieldIndex := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(object := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: fieldIndex))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (object := Arg1Reg)].
	(fieldIndex = ReceiverResultReg or: [object = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: fieldIndex.
	self ssNativePop: 1.
	self ssTop popToReg: object.
	self ssPop: 1.

	objectRepresentation genLcLoadObject: object at: fieldIndex.

	^ 0

