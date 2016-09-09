inline primitive generators generated code
genLowcodeInt32ToFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |

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

	self ConvertR: value Rd: result.
	self ssPushNativeRegisterDoubleFloat: result.

	^ 0

