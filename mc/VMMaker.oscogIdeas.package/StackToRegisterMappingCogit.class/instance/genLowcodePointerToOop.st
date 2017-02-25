inline primitive generators generated code
genLowcodePointerToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer pointerClassLiteral |
	pointerClassLiteral := self getLiteral: extA.

	(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointer := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	pointer = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointer.
	self ssNativePop: 1.

	self ssFlushAll.
	objectRepresentation genLcPointerToOop: pointer class: pointerClassLiteral.

	extA := 0.
	^ 0

