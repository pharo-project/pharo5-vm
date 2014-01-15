object memory support
mapStackPages
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #theIPPtr type: #'char *'>
	"Need to write back the frame pointers unless all pages are free (as in snapshot)"
	stackPage ~= 0 ifTrue:
		[self externalWriteBackHeadFramePointers].
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP callerFP theIPPtr theIP oop |
		thePage := stackPages stackPageAt: i.
		thePage isFree ifFalse:
			[theSP := thePage headSP.
			 theFP := thePage  headFP.
			 "Skip the instruction pointer on top of stack of inactive pages."
			 thePage = stackPage
				ifTrue: [theIPPtr := 0]
				ifFalse:
					[theIPPtr := theSP.
					 theSP := theSP + BytesPerWord].
			[self assert: (thePage addressIsInPage: theFP).
			 self assert: (thePage addressIsInPage: theSP).
			 self assert: (theIPPtr = 0 or: [thePage addressIsInPage: theFP]).
			 [theSP <= (theFP + FoxReceiver)] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory isIntegerObject: oop) ifFalse:
					[stackPages longAt: theSP put: (objectMemory remap: oop)].
				 theSP := theSP + BytesPerWord].
			 (self frameHasContext: theFP) ifTrue:
				[stackPages
					longAt: theFP + FoxThisContext
					put: (objectMemory remap: (self frameContext: theFP))].
			 theIPPtr ~= 0 ifTrue:
				[self assert: (stackPages longAt: theIPPtr) > (self frameMethod: theFP).
				 theIP := (stackPages longAt: theIPPtr) - (self frameMethod: theFP)].
			 stackPages
				longAt: theFP + FoxMethod
				put: (objectMemory remap: (self frameMethod: theFP)).
			 theIPPtr ~= 0 ifTrue:
				[stackPages longAt: theIPPtr put: theIP + (self frameMethod: theFP)].
			 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theSP := (theIPPtr := theFP + FoxCallerSavedIP) + BytesPerWord.
				 theFP := callerFP].
			 theSP := theFP + FoxCallerContext. "a.k.a. FoxCallerSavedIP"
			 [theSP <= thePage baseAddress] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory isIntegerObject: oop) ifFalse:
					[stackPages longAt: theSP put: (objectMemory remap: oop)].
				 theSP := theSP + BytesPerWord]]]