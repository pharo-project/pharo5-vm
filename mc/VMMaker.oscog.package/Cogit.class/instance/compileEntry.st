compile abstract instructions
compileEntry
	"The entry code to a method checks that the class of the current receiver matches
	 that in the inline cache.  Other non-obvious elements are that its alignment must be
	 different from the alignment of the noCheckEntry so that the method map machinery
	 can distinguish normal and super sends (super sends bind to the noCheckEntry).
	 In Newspeak we also need to distinguish dynSuperSends and self sends from normal
	 and super sends and so on Newspeak, bind the dynSuperEntry and selfSendEntry to
	 preceeding nops (on x86 there happens to be at least one anyway)."

	self cppIf: NewspeakVM ifTrue:
		[self Nop. "1st nop differentiates from no-check entry if using nextMethod".
		 dynSuperEntry := self Nop.
		 selfSendEntry := self Nop]. "Put selfSend last as it has higher dynamic frequency."
	entry := objectRepresentation genGetInlineCacheClassTagFrom: ReceiverResultReg into: TempReg forEntry: true.
	self CmpR: ClassReg R: TempReg.
	self JumpNonZero: sendMiss.
	noCheckEntry := self Label.
	self compileSendTrace ifTrue:
		[backEnd saveAndRestoreLinkRegAround:
			[self CallRT: ceTraceLinkedSendTrampoline]]