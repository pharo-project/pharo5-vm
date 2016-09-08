compile abstract instructions
compileEntry
	"The entry code to a method checks that the class of the current receiver matches
	 that in the inline cache.  Other non-obvious elements are that its alignment must be
	 different from the alignment of the noCheckEntry so that the method map machinery
	 can distinguish normal and super sends (super sends bind to the noCheckEntry)."

	entry := objectRepresentation genGetInlineCacheClassTagFrom: ReceiverResultReg into: TempReg forEntry: true.
	self CmpR: ClassReg R: TempReg.
	self JumpNonZero: sendMiss.
	noCheckEntry := self Label.
	self compileSendTrace ifTrue:
		[backEnd saveAndRestoreLinkRegAround:
			[self CallRT: ceTraceLinkedSendTrampoline]]