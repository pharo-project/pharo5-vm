initialization
genPICMissTrampolineFor: numArgs
	| startAddress |
	<var: #aString type: #'char *'>
	<inline: false>
	startAddress := methodZoneBase.
	opcodeIndex := 0.
	"N.B. a closed PIC jumps to the miss routine, not calls it, so there is only one retpc on the stack."
	self genPushRegisterArgsForNumArgs: numArgs.
	self genTrampolineFor: #ceCPICMiss:receiver:
		called: (self trampolineName: 'cePICMiss' numArgs: (numArgs <= self numRegArgs ifTrue: [numArgs] ifFalse: [-1]))
		callJumpBar: true
		numArgs: 2
		arg: ClassReg
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		saveRegs: false
		resultReg: nil
		appendOpcodes: true.
	^startAddress