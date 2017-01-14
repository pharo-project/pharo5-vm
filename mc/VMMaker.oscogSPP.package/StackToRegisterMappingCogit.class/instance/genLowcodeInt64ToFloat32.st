inline primitive generators generated code
genLowcodeInt64ToFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| valueHigh value valueLow result |

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(result := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (result := DPFPReg0)].
	value = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self abort.

	^ 0

