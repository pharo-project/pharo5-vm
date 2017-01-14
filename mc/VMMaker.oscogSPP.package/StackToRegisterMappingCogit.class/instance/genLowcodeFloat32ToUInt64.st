inline primitive generators generated code
genLowcodeFloat32ToUInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| resultLow resultHigh value result |

	(value := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (value := DPFPReg0)].

	(result := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(result := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	result = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self abort.

	^ 0

