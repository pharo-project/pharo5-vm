initialization
genPICMissTrampolineFor: numArgs
	<inline: false>
	| startAddress |
	startAddress := methodZoneBase.
	self zeroOpcodeIndex.
	"N.B. a closed PIC jumps to the miss routine, not calls it, so there is only one retpc on the stack."
	backEnd genPushRegisterArgsForNumArgs: numArgs scratchReg: SendNumArgsReg.
	self genTrampolineFor: #ceCPICMiss:receiver:
		called: (self trampolineName: 'cePICMiss' numRegArgs: numArgs)
		numArgs: 2
		arg: ClassReg
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true
		resultReg: NoReg
		appendOpcodes: true.
	^startAddress