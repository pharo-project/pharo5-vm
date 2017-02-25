object memory support
mapStackPages
	<inline: #never>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #frameRcvrOffset type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #theIPPtr type: #'char *'>
	| numLivePages |
	numLivePages := 0.
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP frameRcvrOffset callerFP theIPPtr theIP oop |
		thePage := stackPages stackPageAt: i.
		thePage isFree ifFalse:
			[self assert: (self ifCurrentStackPageHasValidHeadPointers: thePage).
			 numLivePages := numLivePages + 1.
			 theSP := thePage headSP.
			 theFP := thePage  headFP.
			 "Skip the instruction pointer on top of stack of inactive pages."
			 thePage = stackPage
				ifTrue: [theIPPtr := ((self isMachineCodeFrame: theFP)
									or: [(self iframeSavedIP: theFP) = 0])
										ifTrue: [0]
										ifFalse: [theFP + FoxIFSavedIP]]
				ifFalse:
					[theIPPtr := theSP.
					 theSP := theSP + objectMemory wordSize].
			[self assert: (thePage addressIsInPage: theFP).
			 self assert: (thePage addressIsInPage: theSP).
			 self assert: (theIPPtr = 0 or: [thePage addressIsInPage: theIPPtr]).
			 frameRcvrOffset := self frameReceiverLocation: theFP.
	 		  [theSP <= frameRcvrOffset] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory shouldRemapOop: oop) ifTrue:
					[stackPages longAt: theSP put: (objectMemory remapObj: oop)].
				 theSP := theSP + objectMemory wordSize].
			 (self frameHasContext: theFP) ifTrue:
				[(objectMemory shouldRemapObj: (self frameContext: theFP)) ifTrue:
					[stackPages
						longAt: theFP + FoxThisContext
						put: (objectMemory remapObj: (self frameContext: theFP))].
				 "With SqueakV3 objectMemory or SpurPlanningCompactor can't assert since object body is yet to move."
				 (objectMemory hasSpurMemoryManagerAPI
				  and: [objectMemory slidingCompactionInProgress not]) ifTrue:
					[self assert: ((self isMarriedOrWidowedContext: (self frameContext: theFP))
								and: [(self frameOfMarriedContext: (self frameContext: theFP)) = theFP])]].
			(self isMachineCodeFrame: theFP) ifFalse:
				[(objectMemory shouldRemapObj: (self iframeMethod: theFP)) ifTrue:
					[theIPPtr ~= 0 ifTrue:
						[theIP := stackPages longAt: theIPPtr.
						 theIP = cogit ceReturnToInterpreterPC
							ifTrue:
								[self assert: (self iframeSavedIP: theFP) > (self iframeMethod: theFP).
								 theIPPtr := theFP + FoxIFSavedIP.
								 theIP := stackPages longAt: theIPPtr]
							ifFalse:
								[self assert: theIP > (self iframeMethod: theFP)].
						 theIP := theIP - (self iframeMethod: theFP)].
					 stackPages
						longAt: theFP + FoxMethod
						put: (objectMemory remapObj: (self iframeMethod: theFP)).
					 theIPPtr ~= 0 ifTrue:
						[stackPages longAt: theIPPtr put: theIP + (self iframeMethod: theFP)]]].
			 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theSP := (theIPPtr := theFP + FoxCallerSavedIP) + objectMemory wordSize.
				 theFP := callerFP].
			 theSP := theFP + FoxCallerSavedIP + objectMemory wordSize.
			 [theSP <= thePage baseAddress] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory shouldRemapOop: oop) ifTrue:
					[stackPages longAt: theSP put: (objectMemory remapObj: oop)].
				 theSP := theSP + objectMemory wordSize]]].
	stackPages recordLivePagesOnMapping: numLivePages