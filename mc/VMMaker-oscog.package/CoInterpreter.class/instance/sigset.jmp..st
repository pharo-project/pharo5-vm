cog jit support
sigset:aJumpBuf jmp: sigSaveMask
	"Hack simulation of sigsetjmp/siglongjmp.
	 Assign to reenterInterpreter the exception that when
	 raised simulates a longjmp back to the interpreter." 
	<doNotGenerate>
	reenterInterpreter := ReenterInterpreter new returnValue: 0; yourself.
	^0