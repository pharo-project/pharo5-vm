compile abstract instructions
compileBlockEntry: blockStart
	"Compile a block's entry.  This looks like a dummy CogBlockMethod header (for frame parsing)
	 followed by either a frame build, if a frame is required, or nothing.  The CogMethodHeader's
	 objectHeader field is a back pointer to the method, but this can't be filled in until code generation."
	<var: #blockStart type: #'BlockStart *'>
	self AlignmentNops: (self sizeof: CogBlockMethod).
	self assert: (self sizeof: CogBlockMethod) = (2 * BytesPerWord).
	blockStart fakeHeader: self Label.
	self Fill32: 0. "gets filled in later with the homeOffset and startpc"
	self Fill32: 0. "gets filled in later with numArgs et al"
	blockStart entryLabel: self Label.
	needsFrame
		ifTrue:
			[self compileBlockFrameBuild: blockStart.
			 self recordBlockTrace ifTrue:
				[self CallRT: ceTraceBlockActivationTrampoline]]
		ifFalse:
			[self compileBlockFramelessEntry: blockStart]