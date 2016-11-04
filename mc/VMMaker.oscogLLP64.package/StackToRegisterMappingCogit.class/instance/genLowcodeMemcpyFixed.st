inline primitive generators generated code
genLowcodeMemcpyFixed
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| source size dest |
	size := extA.

	(source := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(source := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(dest := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: source))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (dest := Arg1Reg)].
	(source = ReceiverResultReg or: [dest = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: source.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: dest.
	self ssNativePop: 1.

	size = BytesPerWord ifTrue: [
	self MoveMw: 0 r: source R: TempReg.
	self MoveR: TempReg Mw: 0 r: dest.
	] ifFalse: [
	self ssFlushAll.
	backEnd genMemCopy: source to: dest constantSize: size.
	].

	extA := 0.
	^ 0

