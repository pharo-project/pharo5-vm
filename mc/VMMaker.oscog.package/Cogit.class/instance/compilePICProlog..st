in-line cacheing
compilePICProlog: numArgs
	"The start of a PIC has a call to a run-time abort routine that either handles
	 a dispatch to an interpreted method or a dispatch of an MNU case.  The
	 routine selects the path depending on ClassReg; if zero it takes the MNU
	 path; if nonzero the dispatch to interpreter path.  Neither of these paths
	 returns. The abort routine must be called;  In the callee the PIC is located
	 by adding the relevant offset to the return address of the call."
	mnuCall := self MoveCq: 0 R: ClassReg.
	backEnd hasLinkRegister
		ifTrue:
			["if we have a link register we will assume that it does not get automatically pushed onto the stack
			and thus needs to be manually handled here"
			 interpretLabel := self PushR: LinkReg.
			 interpretCall := self Call: (self picAbortTrampolineFor: numArgs)]
		ifFalse:
			[interpretLabel :=
			 interpretCall := self Call: (self picAbortTrampolineFor: numArgs)].
	^0