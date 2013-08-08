simulation stack
availableRegisterOrNil
	<returnTypeC: #sqInt>
	| liveRegs |
	liveRegs := self liveRegisters.
	(liveRegs anyMask: (self registerMaskFor: Arg1Reg)) ifFalse:
		[^Arg1Reg].
	(liveRegs anyMask: (self registerMaskFor: Arg0Reg)) ifFalse:
		[^Arg0Reg].
	(liveRegs anyMask: (self registerMaskFor: SendNumArgsReg)) ifFalse:
		[^SendNumArgsReg].
	(liveRegs anyMask: (self registerMaskFor: ClassReg)) ifFalse:
		[^ClassReg].
	(liveRegs anyMask: (self registerMaskFor: ReceiverResultReg)) ifFalse:
		[^ReceiverResultReg].
	^nil