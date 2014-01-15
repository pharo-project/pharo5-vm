object memory support
mapStackPages
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #frameRcvrOffset type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #theIPPtr type: #'char *'>
	"Need to write back the frame pointers unless all pages are free (as in snapshot)"
	stackPage ~= 0 ifTrue:
		[self externalWriteBackHeadFramePointers].
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP frameRcvrOffset callerFP theIPPtr theIP oop |
		thePage := stackPages stackPageAt: i.
		thePage isFree ifFalse:
			[theSP := thePage headSP.
			 theFP := thePage  headFP.
			 "Skip the instruction pointer on top of stack of inactive pages."
			 thePage = stackPage
				ifTrue: [theIPPtr := ((self isMachineCodeFrame: theFP)
									or: [(self iframeSavedIP: theFP) = 0])
										ifTrue: [0]
										ifFalse: [theFP + FoxIFSavedIP]]
				ifFalse:
					[theIPPtr := theSP.
					 theSP := theSP + BytesPerWord].
			[self assert: (thePage addressIsInPage: theFP).
			 self assert: (thePage addressIsInPage: theSP).
			 self assert: (theIPPtr = 0 or: [thePage addressIsInPage: theFP]).
			 frameRcvrOffset := self frameReceiverOffset: theFP.
	 		  [theSP <= frameRcvrOffset] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory isIntegerObject: oop) ifFalse:
					[stackPages longAt: theSP put: (objectMemory remap: oop)].
				 theSP := theSP + BytesPerWord].
			 (self frameHasContext: theFP) ifTrue:
				[stackPages
					longAt: theFP + FoxThisContext
					put: (objectMemory remap: (self frameContext: theFP))].
			(self isMachineCodeFrame: theFP) ifFalse:
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
					put: (objectMemory remap: (self iframeMethod: theFP)).
				 theIPPtr ~= 0 ifTrue:
					[stackPages longAt: theIPPtr put: theIP + (self iframeMethod: theFP)]].
			 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theSP := (theIPPtr := theFP + FoxCallerSavedIP) + BytesPerWord.
				 theFP := callerFP].
			 theSP := theFP + FoxCallerSavedIP + BytesPerWord.
			 [theSP <= thePage baseAddress] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory isIntegerObject: oop) ifFalse:
					[stackPages longAt: theSP put: (objectMemory remap: oop)].
				 theSP := theSP + BytesPerWord]]]