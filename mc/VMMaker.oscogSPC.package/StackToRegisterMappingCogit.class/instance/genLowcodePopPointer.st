inline primitive generators generated code
genLowcodePopPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerValue |

	(pointerValue := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointerValue := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointerValue = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointerValue.
	self ssNativePop: 1.


	^ 0

