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
			[interpretLabel := self PushR: LinkReg.
			 interpretCall := self Call: (self picAbortTrampolineFor: numArgs)]
		ifFalse:
			[interpretLabel :=
			 interpretCall := self Call: (self picAbortTrampolineFor: numArgs)].
	^0