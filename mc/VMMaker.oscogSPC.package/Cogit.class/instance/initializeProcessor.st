initialization
initializeProcessor
	"Initialize the simulation processor, arranging that its initial stack is somewhere on the rump C stack."
	<doNotGenerate>
	guardPageSize := self class guardPageSize.
	lastNInstructions := OrderedCollection new.
	processor initializeStackFor: self.
	self initializeProcessorStack: coInterpreter rumpCStackAddress.
	self setCFramePointer: processor fp.
	self setCStackPointer: processor sp.
	threadManager ifNotNil:
		[processor := MultiProcessor for: processor coInterpreter: coInterpreter]