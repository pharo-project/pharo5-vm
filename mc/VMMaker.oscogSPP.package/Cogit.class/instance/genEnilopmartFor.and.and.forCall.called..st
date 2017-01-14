initialization
genEnilopmartFor: regArg1 and: regArg2OrNone and: regArg3OrNone forCall: forCall called: trampolineName
	"An enilopmart (the reverse of a trampoline) is a piece of code that makes
	 the system-call-like transition from the C runtime into generated machine
	 code.  The desired arguments and entry-point are pushed on a stackPage's
	 stack.  The enilopmart pops off the values to be loaded into registers and
	 then executes a return instruction to pop off the entry-point and jump to it.

						BEFORE				AFTER			(stacks grow down)
						whatever			stackPointer ->	whatever
						target address =>	reg1 = reg1val, etc
						reg1val				pc = target address
						reg2val
		stackPointer ->	reg3val"

	<var: #trampolineName type: #'char *'>
	<returnTypeC: #'void (*genEnilopmartForandandforCallcalled(sqInt regArg1, sqInt regArg2OrNone, sqInt regArg3OrNone, sqInt forCall, char *trampolineName))(void)'>

	| size endAddress enilopmart |
	self zeroOpcodeIndex.
	backEnd hasVarBaseRegister ifTrue:
		[self MoveCq: self varBaseAddress R: VarBaseReg]. "Must happen first; value may be used in genLoadStackPointers"
	backEnd genLoadStackPointers.
	regArg3OrNone ~= NoReg ifTrue: [self PopR: regArg3OrNone].
	regArg2OrNone ~= NoReg ifTrue: [self PopR: regArg2OrNone].
	self PopR: regArg1.
	self genEnilopmartReturn: forCall.
	self computeMaximumSizes.
	size := self generateInstructionsAt: methodZoneBase.
	endAddress := self outputInstructionsAt: methodZoneBase.
	self assert: methodZoneBase + size = endAddress.
	enilopmart := methodZoneBase.
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	backEnd stopsFrom: endAddress to: methodZoneBase - 1.
	self recordGeneratedRunTime: trampolineName address: enilopmart.
	^self cCoerceSimple: enilopmart to: #'void (*)(void)'