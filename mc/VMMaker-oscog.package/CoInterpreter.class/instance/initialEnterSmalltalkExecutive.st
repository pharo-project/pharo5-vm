initialization
initialEnterSmalltalkExecutive
	"Main entry-point into the interpreter at system start-up.
	 In the non-threaded VM this is identical to enterSmalltalkExecutive"
	<cmacro: '() enterSmalltalkExecutiveImplementation()'>
	"Simulation of the setjmp in enterSmalltalkExecutiveImplementation for reentry into interpreter."
	[([self enterSmalltalkExecutiveImplementation]
		on: ReenterInterpreter
		do: [:ex| ex return: ex returnValue]) = ReturnToInterpreter] whileTrue