initialization
genCallEnilopmartFor: regArg1 and: regArg2 and: regArg3 called: trampolineName
	"An enilopmart (the reverse of a trampoline) is a piece of code that makes
	 the system-call-like transition from the C runtime into generated machine
	 code.  This version is for entering code as if from a call.  The desired
	 arguments and entry-point are pushed on a stackPage's stack, and beneath
	 them is the call's return address.  The enilopmart pops off the values to be
	 loaded into registers, and on CISCs then executes a return instruction to pop
	 off the entry-point and jump to it.  On RISCs the enilopmart pops off the values
	 to be loaded into registers, pops the entry-point into a scratch register, pops
	 the return address into the LinkReg and then jumps to the entry point.

						BEFORE				AFTER			(stacks grow down)
						whatever			stackPointer ->	whatever
						call return pc
						target address =>
						reg1val				reg1 = reg1val, etc
						reg2val				LinkReg = call return pc
		stackPointer ->	reg3val				pc = target address

	 C.F. genEnilopmartFor:and:and:called:"
	<returnTypeC: 'void (*genCallEnilopmartForandandcalled(sqInt regArg1, sqInt regArg2, sqInt regArg3, char *trampolineName))(void)'>
	| size endAddress enilopmart |
	opcodeIndex := 0.
	backEnd genLoadStackPointers.
	self PopR: regArg3.
	self PopR: regArg2.
	self PopR: regArg1.
	backEnd hasLinkRegister
		ifTrue:
			[self PopR: TempReg.
			 self PopR: LinkReg.
			 self JumpR: TempReg]
		ifFalse:
			[self RetN: 0].
	self computeMaximumSizes.
	size := self generateInstructionsAt: methodZoneBase.
	endAddress := self outputInstructionsAt: methodZoneBase.
	self assert: methodZoneBase + size = endAddress.
	enilopmart := methodZoneBase.
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	backEnd nopsFrom: endAddress to: methodZoneBase - 1.
	self recordGeneratedRunTime: trampolineName address: enilopmart.
	^self cCoerceSimple: enilopmart to: #'void (*)(void)'