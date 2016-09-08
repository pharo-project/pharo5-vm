inline primitive generators generated code
genLowcodeFloat32ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| singleFloatValue object |

	(singleFloatValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (singleFloatValue := DPFPReg0)].

	(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(object := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	object = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: singleFloatValue.
	self ssNativePop: 1.

	self ssFlushAll.
	objectRepresentation genLcFloat32: singleFloatValue toOop: object.

	^ 0

