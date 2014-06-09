initialization
initializeProcessor
	"Initialize the simulation processor, arranging that its initial stack is somewhere on the rump C stack."
	<doNotGenerate>
	guardPageSize := self class guardPageSize.
	lastNInstructions := OrderedCollection new.
	processor initializeStackFor: self.
	self initializeProcessorStack: coInterpreter rumpCStackAddress.
	objectMemory
		longAt: self cFramePointerAddress put: processor fp;
		longAt: self cStackPointerAddress put: processor sp.
	threadManager ifNotNil:
		[processor := MultiProcessor for: processor coInterpreter: coInterpreter]