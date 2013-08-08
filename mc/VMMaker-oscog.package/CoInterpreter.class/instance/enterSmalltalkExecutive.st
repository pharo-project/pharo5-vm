initialization
enterSmalltalkExecutive
	"Main entry-point into the interpreter at each execution level, where an
	 execution level is either the start of execution or reentry for a callback."
	<cmacro: '() enterSmalltalkExecutiveImplementation()'>
	"Simulation of the setjmp in enterSmalltalkExecutiveImplementation for reentry into interpreter."
	[([self enterSmalltalkExecutiveImplementation]
		on: ReenterInterpreter
		do: [:ex| ex return: ex returnValue]) = ReturnToInterpreter] whileTrue