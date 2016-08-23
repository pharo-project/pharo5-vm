callback support
reestablishContextPriorToCallback: callbackContext
	"callbackContext is an activation of invokeCallback:[stack:registers:jmpbuf:].
	 Its sender is the VM's state prior to the callback.  Reestablish that state,
	 and mark calloutContext as dead."
	| calloutContext theFP thePage |
	<export: true>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	self flag: #obsolete.
	(self isLiveContext: callbackContext) ifFalse:
		[^false].
	calloutContext := self externalInstVar: SenderIndex ofContext: callbackContext.
	(self isLiveContext: calloutContext) ifFalse:
		[^false].
	"We're about to leave this stack page; must save the current frame's instructionPointer."
	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	"Mark callbackContext as dead; the common case is that it is the current frame.
	 We go the extra mile for the debugger."
	(self isSingleContext: callbackContext)
		ifTrue: [self markContextAsDead: callbackContext]
		ifFalse:
			[theFP := self frameOfMarriedContext: callbackContext.
			 framePointer = theFP "common case"
				ifTrue:
					[(self isBaseFrame: theFP)
						ifTrue: [stackPages freeStackPage: stackPage]
						ifFalse: "calloutContext is immediately below on the same page.  Make it current."
							[instructionPointer := (self frameCallerSavedIP: framePointer) asUnsignedInteger.
							 stackPointer := framePointer + (self frameStackedReceiverOffset: framePointer) + objectMemory wordSize.
							 framePointer := self frameCallerFP: framePointer.
							 ^true]]
				ifFalse:
					[self externalDivorceFrame: theFP andContext: callbackContext.
					 self markContextAsDead: callbackContext]].
	"Make the calloutContext the active frame.  The case where calloutContext
	 is immediately below callbackContext on the same page is handled above."
	(self isStillMarriedContext: calloutContext)
		ifTrue:
			[theFP := self frameOfMarriedContext: calloutContext.
			 thePage := stackPages stackPageFor: theFP.
			 "findSPOf:on: points to the word beneath the instructionPointer, but
			  there is no instructionPointer on the top frame of the current page."
			 self assert: thePage ~= stackPage.
			 stackPointer := (self findSPOf: theFP on: thePage) - objectMemory wordSize.
			 framePointer := theFP]
		ifFalse:
			[thePage := self makeBaseFrameFor: calloutContext.
			 framePointer := thePage headFP.
			 stackPointer := thePage headSP].
	instructionPointer := self popStack.
	self setStackPageAndLimit: thePage.
	^true