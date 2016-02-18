object memory support
printStackReferencesTo: oop
	<api>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP callerFP |
		thePage := stackPages stackPageAt: i.
		thePage isFree ifFalse:
			[theSP := thePage headSP.
			 theFP := thePage headFP.
			 "Skip the instruction pointer on top of stack of inactive pages."
			 thePage = stackPage ifFalse:
				[theSP := theSP + objectMemory wordSize].
			 [[theSP <= (self frameReceiverLocation: theFP)] whileTrue:
				[oop = (stackPages longAt: theSP) ifTrue:
					[self print: 'FP: '; printHexnp: theFP; print: ' @ '; printHexnp: theSP; cr].
				 theSP := theSP + objectMemory wordSize].
			  (self frameHasContext: theFP) ifTrue:
				[oop = (self frameContext: theFP) ifTrue:
					[self print: 'FP: '; printHexnp: theFP; print: ' CTXT'; cr]].
			  oop = (self frameMethod: theFP) ifTrue:
				[self print: 'FP: '; printHexnp: theFP; print: ' MTHD'; cr].
			  (callerFP := self frameCallerFP: theFP) ~= 0]
				whileTrue:
					[theSP := (theFP + FoxCallerSavedIP) + objectMemory wordSize.
					 theFP := callerFP].
			 theSP := theFP + FoxCallerSavedIP. "a.k.a. FoxCallerContext"
			 [theSP <= thePage baseAddress] whileTrue:
				[oop = (stackPages longAt: theSP) ifTrue:
					[self print: 'FP: '; printHexnp: theFP; print: ' @ '; printHexnp: theSP; cr].
				 theSP := theSP + objectMemory wordSize]]]