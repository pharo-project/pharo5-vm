class initialization
initializeMiscConstants
	super initializeMiscConstants.
	Debug := initializationOptions at: #Debug ifAbsent: [false].
	(initializationOptions includesKey: #EagerInstructionDecoration)
		ifTrue:
			[EagerInstructionDecoration := initializationOptions at: #EagerInstructionDecoration]
		ifFalse:
			[EagerInstructionDecoration ifNil:
				[EagerInstructionDecoration := false]]. "speeds up single stepping but could lose fidelity"

	ProcessorClass := (initializationOptions at: #ISA ifAbsentPut: [self objectMemoryClass defaultISA]) caseOf: {
							[#X64] 		->	[BochsX64Alien].
							[#IA32] 	->	[BochsIA32Alien].
							[#ARMv5]	->	[GdbARMAlien].
							[#MIPSEL]	->	[MIPSELSimulator] }.
	CogCompilerClass := self activeCompilerClass.
	(CogCompilerClass withAllSuperclasses copyUpTo: CogAbstractInstruction) reverseDo:
		[:compilerClass| compilerClass initialize; initializeAbstractRegisters].
	self objectMemoryClass objectRepresentationClass initializeMiscConstants.
	"Our criterion for which methods to JIT is literal count.  The default value is 60 literals or less."
	MaxLiteralCountForCompile := initializationOptions at: #MaxLiteralCountForCompile ifAbsent: [60].
	"we special-case 0, 1 & 2 argument sends, N is numArgs >= 3"
	NumSendTrampolines := 4.
	"Currently not even the ceImplicitReceiverTrampoline contains object references."
	NumObjRefsInRuntime := 0.
	"6 is a fine number for the max number of PCI entries.  8 is too large."
	MaxCPICCases := 6.

	"One variable defines whether in a block and whether in a vanilla or full block."
	InVanillaBlock := 1.
	InFullBlock := 2.

	NSCSelectorIndex := (NSSendCache instVarNames indexOf: #selector) - 1.
	NSCNumArgsIndex := (NSSendCache instVarNames indexOf: #numArgs) - 1.
	NSCClassTagIndex := (NSSendCache instVarNames indexOf: #classTag) - 1.
	NSCEnclosingObjectIndex := (NSSendCache instVarNames indexOf: #enclosingObject) - 1.
	NSCTargetIndex := (NSSendCache instVarNames indexOf: #target) - 1.
	NumOopsPerNSC := NSSendCache instVarNames size.

	"Max size to alloca when compiling.
	 Mac OS X 10.6.8 segfaults approaching 8Mb.
	 Linux 2.6.9 segfaults above 11Mb.
	 WIndows XP segfaults approaching 2Mb."
	MaxStackAllocSize := 1024 * 1024 * 3 / 2 