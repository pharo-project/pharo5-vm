inline primitive generators generated code
genLowcodeFloat64ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue object |

	(floatValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (floatValue := DPFPReg0)].

	(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(object := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	object = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: floatValue.
	self ssNativePop: 1.

	self ssFlushAll.
	objectRepresentation genLcFloat64: floatValue toOop: object.

	^ 0

