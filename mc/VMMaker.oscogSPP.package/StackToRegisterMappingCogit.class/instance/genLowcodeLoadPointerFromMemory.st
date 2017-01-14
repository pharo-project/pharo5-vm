inline primitive generators generated code
genLowcodeLoadPointerFromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerResult pointer |

	(pointer := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(pointer := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(pointerResult := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: pointer))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (pointerResult := Arg1Reg)].
	(pointer = ReceiverResultReg or: [pointerResult = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: pointer.
	self ssNativePop: 1.

	self MoveMw: 0 r: pointer R: pointerResult.
	self ssPushNativeRegister: pointerResult.

	^ 0

