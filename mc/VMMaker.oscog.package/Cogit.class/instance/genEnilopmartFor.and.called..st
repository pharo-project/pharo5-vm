initialization
genEnilopmartFor: regArg1 and: regArg2 called: trampolineName
	"An enilopmart (the reverse of a trampoline) is a piece of code that makes
	 the system-call-like transition from the C runtime into generated machine
	 code.  The desired arguments and entry-point are pushed on a stackPage's
	 stack.  The enilopmart pops off the values to be loaded into registers and
	 then executes a return instruction to pop off the entry-point and jump to it."
	<returnTypeC: 'void (*genEnilopmartForandcalled(sqInt regArg1, sqInt regArg2, char *trampolineName))(void)'>
	| size endAddress enilopmart |
	opcodeIndex := 0.
	backEnd genLoadStackPointers.
	self PopR: regArg2.
	self PopR: regArg1.
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	self RetN: 0.
	self computeMaximumSizes.
	size := self generateInstructionsAt: methodZoneBase.
	endAddress := self outputInstructionsAt: methodZoneBase.
	self assert: methodZoneBase + size = endAddress.
	enilopmart := methodZoneBase.
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	backEnd nopsFrom: endAddress to: methodZoneBase - 1.
	self recordGeneratedRunTime: trampolineName address: enilopmart.
	^self cCoerceSimple: enilopmart to: #'void (*)(void)'