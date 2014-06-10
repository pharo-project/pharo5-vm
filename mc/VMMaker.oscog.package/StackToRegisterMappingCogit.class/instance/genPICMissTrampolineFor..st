initialization
genPICMissTrampolineFor: numArgs
	<inline: false>
	| startAddress |
	startAddress := methodZoneBase.
	opcodeIndex := 0.
	"N.B. a closed PIC jumps to the miss routine, not calls it, so there is only one retpc on the stack."
	backEnd genPushRegisterArgsForNumArgs: numArgs.
	self genTrampolineFor: #ceCPICMiss:receiver:
		called: (self trampolineName: 'cePICMiss' numArgs: (numArgs <= self numRegArgs ifTrue: [numArgs] ifFalse: [-1]))
		numArgs: 2
		arg: ClassReg
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		saveRegs: false
		pushLinkReg: true
		resultReg: nil
		appendOpcodes: true.
	^startAddress