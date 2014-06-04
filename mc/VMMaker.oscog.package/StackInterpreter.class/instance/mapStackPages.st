object memory support
mapStackPages
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #theIPPtr type: #'char *'>
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
			 self assert: (theIPPtr = 0 or: [thePage addressIsInPage: theIPPtr]).
			 [theSP <= (theFP + FoxReceiver)] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory shouldRemapOop: oop) ifTrue:
					[stackPages longAt: theSP put: (objectMemory remapObj: oop)].
				 theSP := theSP + BytesPerWord].
			 (self frameHasContext: theFP) ifTrue:
				[(objectMemory shouldRemapObj: (self frameContext: theFP)) ifTrue:
					[stackPages
						longAt: theFP + FoxThisContext
						put: (objectMemory remapObj: (self frameContext: theFP))].
				 "With SqueakV3 objectMemory can't assert since object body is yet to move."
				 objectMemory hasSpurMemoryManagerAPI ifTrue:
					[self assert: ((self isMarriedOrWidowedContext: (self frameContext: theFP))
								  and: [(self frameOfMarriedContext: (self frameContext: theFP)) = theFP])]].
			 (objectMemory shouldRemapObj: (self frameMethod: theFP)) ifTrue:
				[theIPPtr ~= 0 ifTrue:
					[self assert: (stackPages longAt: theIPPtr) > (self frameMethod: theFP).
					 theIP := (stackPages longAt: theIPPtr) - (self frameMethod: theFP)].
				 stackPages
					longAt: theFP + FoxMethod
					put: (objectMemory remapObj: (self frameMethod: theFP)).
				 theIPPtr ~= 0 ifTrue:
					[stackPages longAt: theIPPtr put: theIP + (self frameMethod: theFP)]].
			 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theSP := (theIPPtr := theFP + FoxCallerSavedIP) + BytesPerWord.
				 theFP := callerFP].
			 theSP := theFP + FoxCallerContext. "a.k.a. FoxCallerSavedIP"
			 [theSP <= thePage baseAddress] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory shouldRemapOop: oop) ifTrue:
					[stackPages longAt: theSP put: (objectMemory remapObj: oop)].
				 theSP := theSP + BytesPerWord]]]