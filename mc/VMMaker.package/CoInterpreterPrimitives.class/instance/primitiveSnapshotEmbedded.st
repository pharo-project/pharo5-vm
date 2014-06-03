system control primitives
primitiveSnapshotEmbedded
	"Save an embedded snapshot.

	 Override to jump to the interpreter because the machine code zone is now void."
	<inline: false>
	self snapshot: true.
	(self iframeMethod: framePointer) = newMethod ifTrue:
		["snapshot: has reached the end and built a frame.
		 In the JIT we need to back-up the pc before reentering the interpreter."
		instructionPointer := instructionPointer - 1].
	self siglong: reenterInterpreter jmp: ReturnToInterpreter
	"NOTREACHED"