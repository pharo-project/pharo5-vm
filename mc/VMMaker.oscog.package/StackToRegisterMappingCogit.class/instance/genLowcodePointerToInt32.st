inline primitive generators generated code
genLowcodePointerToInt32
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

	"TODO: Perform a NOP here"
	self ssPushNativeRegister: pointer.

	^ 0

