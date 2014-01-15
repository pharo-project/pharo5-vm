compile abstract instructions
compileEntry
	"The entry code to a method checks that the class of the current receiver matches
	 that in the inline cache.  Other non-obvious elements are that its alignment must be
	 different from the alignment of the noCheckEntry so that the method map machinery
	 can distinguish normal and super sends (super sends bind to the noCheckEntry).
	 In Newspeak we also need to distinguish dynSuperSends from normal and super
	 and so bind a the preceeding nop (on x86 there happens to be one anyway)."
	self cppIf: NewspeakVM
		ifTrue: [dynSuperEntry := self Nop].
	self AlignmentNops: (BytesPerWord max: 8).
	entry := self Label.
	objectRepresentation getInlineCacheClassTagFrom: ReceiverResultReg into: TempReg.
	self CmpR: ClassReg R: TempReg.
	self JumpNonZero: sendMissCall.
	noCheckEntry := self Label.
	self recordSendTrace ifTrue:
		[self CallRT: ceTraceLinkedSendTrampoline]