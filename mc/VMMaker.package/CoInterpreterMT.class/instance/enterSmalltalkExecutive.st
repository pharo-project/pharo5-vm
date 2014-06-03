initialization
enterSmalltalkExecutive
	"Main entry-point into the interpreter at each execution level, where an
	 execution level is either the start of execution or reentry for a callback."
	<cmacro: '() enterSmalltalkExecutiveImplementation()'>
	"Simulation of the setjmp in enterSmalltalkExecutiveImplementation for reentry
	 into interpreter.  Simulation of the register state switch on thread switch."
	| vmo tlti thisActivationsSP thisActivationsFP retVal |
	[vmo := cogThreadManager getVMOwner.
	 tlti := cogThreadManager ioGetThreadLocalThreadIndex.
	 self assert: vmo = tlti.
	 thisActivationsSP := cogit processor sp.
	 thisActivationsFP := cogit processor fp.
	 retVal := [self enterSmalltalkExecutiveImplementation]
				on: ReenterInterpreter
				do: [:ex|
					vmo := cogThreadManager getVMOwner.
					tlti := cogThreadManager ioGetThreadLocalThreadIndex.
					self assert: (ex returnValue = ReturnToThreadSchedulingLoop
								 or: [vmo = tlti]).
					ex return: ex returnValue].
	 "We must cut back the stack pointers on return to mimic the longjmp."
	 cogit processor
		setFramePointer: thisActivationsFP
		stackPointer: thisActivationsSP.
	 retVal = ReturnToInterpreter] whileTrue