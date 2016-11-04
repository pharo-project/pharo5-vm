inline primitive generators generated code
genLowcodeMemcpy32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| source dest size |

	(size := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(size := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(source := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: size))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (source := Arg1Reg)].

	(dest := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: size)) bitOr: (self registerMaskFor: source))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (dest := SendNumArgsReg)].
	((size = ReceiverResultReg or: [source = ReceiverResultReg]) or: [dest = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: size.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: source.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: dest.
	self ssNativePop: 1.

	self ssFlushAll.
	backEnd genMemCopy: source to: dest size: size.

	^ 0

