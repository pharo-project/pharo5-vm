class initialization
initializeMiscConstantsWith: optionsDictionary
	super initializeMiscConstantsWith: optionsDictionary.
	Debug := optionsDictionary at: #Debug ifAbsent: [false].
	(optionsDictionary includesKey: #EagerInstructionDecoration)
		ifTrue:
			[EagerInstructionDecoration := optionsDictionary at: #EagerInstructionDecoration]
		ifFalse:
			[EagerInstructionDecoration isNil ifTrue:
				[EagerInstructionDecoration := false]]. "speeds up single stepping but could lose fidelity"

	ProcessorClass := (optionsDictionary at: #ISA ifAbsent: [#IA32]) caseOf: {
							[#IA32] 	->	[BochsIA32Alien].
							[#ARMv5]	->	[GdbARMAlien]. }.
	"we special-case 0, 1 & 2 argument sends, N is numArgs >= 3"
	NumSendTrampolines := 4.
	"Currently only the ceImplicitReceiverTrampoline contains object references."
	NumObjRefsInRuntime := 2.
	"Max size to alloca when compiling.
	 Mac OS X 10.6.8 segfaults approaching 8Mb.
	 Linux 2.6.9 segfaults above 11Mb.
	 WIndows XP segfaults approaching 2Mb."
	MaxStackAllocSize := 1024 * 1024 * 3 / 2 