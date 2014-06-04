code compaction
updateStackZoneReferencesToCompiledCodePreCompaction
	<api>
	<var: #thePage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #theIPPtr type: #'char *'>
	<var: #theIP type: #usqInt>
	<var: #theMethod type: #'CogMethod *'>
	0 to: numStackPages - 1 do:
		[:i| | thePage theFP callerFP theIPPtr theIP theMethodField theFlags theMethod |
		thePage := stackPages stackPageAt: i.
		(stackPages isFree: thePage) ifFalse:
			[theIPPtr := thePage headSP.
			 theFP := thePage  headFP.
			 [(self isMachineCodeFrame: theFP) ifTrue:
				[theMethodField := self frameMethodField: theFP.
				 theFlags := theMethodField bitAnd: MFMethodFlagsMask.
				 theMethod := self cCoerceSimple: theMethodField - theFlags to: #'CogMethod *'.
				 theMethod cmType = CMBlock ifTrue:
					[theMethod := (self cCoerceSimple: theMethodField - theFlags to: #'CogBlockMethod *') cmHomeMethod].
				 theIP := (stackPages longAt: theIPPtr) asUnsignedInteger.
				 (theIP ~= cogit ceCannotResumePC
				  and: [self asserta: (theIP >= theMethod asUnsignedInteger
							   and: [theIP < (theMethod asUnsignedInteger + theMethod blockSize)])]) ifTrue:
					[stackPages
						longAt: theIPPtr
						put: theIP + theMethod objectHeader].
				 stackPages
					longAt: theFP + FoxMethod
					put: theMethodField + theMethod objectHeader].
			 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theIPPtr := theFP + FoxCallerSavedIP.
				 theFP := callerFP]]]