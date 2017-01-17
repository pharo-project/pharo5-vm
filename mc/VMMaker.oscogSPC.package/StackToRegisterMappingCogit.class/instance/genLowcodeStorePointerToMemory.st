inline primitive generators generated code
genLowcodeStorePointerToMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| memoryPointer pointerValue |

	(memoryPointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(memoryPointer := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(pointerValue := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: memoryPointer))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (pointerValue := Arg1Reg)].
	(memoryPointer = ReceiverResultReg or: [pointerValue = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: memoryPointer.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: pointerValue.
	self ssNativePop: 1.

	self MoveR: pointerValue Mw: 0 r: memoryPointer.

	^ 0

