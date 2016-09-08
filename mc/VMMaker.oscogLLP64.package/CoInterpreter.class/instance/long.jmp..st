cog jit support
long: aJumpBuf jmp: returnValue
	"Hack simulation of setjmp/longjmp.
	 Signal the exception that simulates a longjmp back to the interpreter." 
	<doNotGenerate>
	aJumpBuf == reenterInterpreter ifTrue:
		[self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: true line: nil].
	aJumpBuf returnValue: returnValue; signal