inline primitive generators generated code
genLowcodePointerToOopReinterprer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer |

	(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointer := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointer = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointer.
	self ssNativePop: 1.

	"TODO: Generate a nop here"
	self ssPushRegister: pointer.

	^ 0

