system control primitives
primitiveSnapshot
	"Save a normal snapshot under the same name as it was loaded
	 unless it has been renamed by the last primitiveImageName.

	 Override to jump to the interpreter because the machine code zone is now void."
	<inline: false>
	self snapshot: false.
	(self iframeMethod: framePointer) = newMethod ifTrue:
		["snapshot: has reached the end and built a frame.
		 In the JIT we need to back-up the pc before reentering the interpreter."
		instructionPointer := instructionPointer - 1].
	self siglong: reenterInterpreter jmp: ReturnToInterpreter
	"NOTREACHED"