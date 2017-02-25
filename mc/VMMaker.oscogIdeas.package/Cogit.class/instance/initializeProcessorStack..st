initialization
initializeProcessorStack: rumpCStackAddress
	"Initialize the simulation processor's stack pointers, arranging that they are somewhere on the rump C stack."
	<doNotGenerate>
	| stackPad cFramePointer cStackPointer |
	stackPad := 64 max: cStackAlignment.
	cStackPointer := rumpCStackAddress - stackPad + expectedSPAlignment.
	cFramePointer := rumpCStackAddress - stackPad + cStackAlignment + expectedFPAlignment.
	self assert: cStackPointer \\ cStackAlignment = expectedSPAlignment.
	self assert: cFramePointer \\ cStackAlignment = expectedFPAlignment.
	processor setFramePointer: cFramePointer stackPointer: cStackPointer