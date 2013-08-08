initialization
initializeProcessor
	"Initialize the simulation processor, arranging that its initial stack is somewhere on the rump C stack."
	<doNotGenerate>
	guardPageSize := 1024.
	lastNInstructions := OrderedCollection new.
	"This is for testing.  On many OS's the stack must remain aligned;
	 e.g. IA32 using SSE requires 16 byte alignment."
	expectedSPAlignment := 0. expectedFPAlignment := 8. cStackAlignment := 16.
	processor class setStackAlignmentDelta: cStackAlignment.
	self initializeProcessorStack: coInterpreter rumpCStackAddress.
	objectMemory
		longAt: self cFramePointerAddress put: processor fp;
		longAt: self cStackPointerAddress put: processor sp.
	threadManager ifNotNil:
		[processor := MultiProcessor for: processor coInterpreter: coInterpreter]