in-line cacheing
compilePICAbort: numArgs
	"The start of a PIC has a call to a run-time abort routine that either handles a dispatch to an
	 interpreted method or a dispatch of an MNU case.  The routine selects the path by testing
	 ClassReg, which holds the inline cache tag; if equal to the picAbortDiscriminatorValue (zero)
	 it takes the MNU path; if nonzero the dispatch to interpreter path.  Neither of these paths
	 returns. The abort routine must be called;  In the callee the PIC is located by adding the
	 relevant offset to the return address of the call.

	 N.B. This code must match that in compileAbort so that the offset of the return address of
	 the call is the same in methods and closed PICs."
	picMNUAbort := self MoveCq: self picAbortDiscriminatorValue R: ClassReg.
	backEnd hasLinkRegister
		ifTrue:
			["If there is a link register it must be saved (pushed onto the stack) before it
			  is smashed by the abort call, and hence needs to be manually handled here".
			 picInterpretAbort := self PushR: LinkReg.
			 self Call: (self picAbortTrampolineFor: numArgs)]
		ifFalse:
			[picInterpretAbort := self Call: (self picAbortTrampolineFor: numArgs)].
	^0