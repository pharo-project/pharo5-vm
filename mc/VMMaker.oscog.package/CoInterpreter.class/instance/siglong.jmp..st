cog jit support
siglong: aJumpBuf jmp: returnValue
	"Hack simulation of sigsetjmp/siglongjmp.
	 Signal the exception that simulates a longjmp back to the interpreter." 
	<doNotGenerate>
	(aJumpBuf == reenterInterpreter
	 and: [returnValue ~= 2 "2 == returnToThreadSchedulingLoopVia:"]) ifTrue:
		[self assert: (self isOnRumpCStack: cogit processor sp).
		 self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: true line: nil].
	aJumpBuf returnValue: returnValue; signal