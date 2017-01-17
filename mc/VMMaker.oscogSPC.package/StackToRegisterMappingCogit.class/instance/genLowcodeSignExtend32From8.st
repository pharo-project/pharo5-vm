inline primitive generators generated code
genLowcodeSignExtend32From8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value |

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	value = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self SignExtend8R: value R: value.
	self ssPushNativeRegister: value.

	^ 0

