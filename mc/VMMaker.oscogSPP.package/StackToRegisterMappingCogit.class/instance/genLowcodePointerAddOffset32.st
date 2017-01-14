inline primitive generators generated code
genLowcodePointerAddOffset32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| base offset |

	(offset := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(offset := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(base := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: offset))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (base := Arg1Reg)].
	(offset = ReceiverResultReg or: [base = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: offset.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: base.
	self ssNativePop: 1.

	self AddR: offset R: base.
	self ssPushNativeRegister: base.

	^ 0

