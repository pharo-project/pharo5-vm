callback support
returnAs: returnTypeOop ThroughCallback: vmCallbackContext Context: callbackMethodContext
	"callbackMethodContext is an activation of invokeCallback:[stack:registers:jmpbuf:].
	 Its sender is the VM's state prior to the callback.  Reestablish that state (via longjmp),
	 and mark callbackMethodContext as dead."
	<export: true>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	| calloutMethodContext theFP thePage |
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	((self isIntegerObject: returnTypeOop)
	 and: [self isLiveContext: callbackMethodContext]) ifFalse:
		[^false].
	calloutMethodContext := self externalInstVar: SenderIndex ofContext: callbackMethodContext.
	(self isLiveContext: calloutMethodContext) ifFalse:
		[^false].
	"We're about to leave this stack page; must save the current frame's instructionPointer."
	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	"Mark callbackMethodContext as dead; the common case is that it is the current frame.
	 We go the extra mile for the debugger."
	(self isSingleContext: callbackMethodContext)
		ifTrue: [self markContextAsDead: callbackMethodContext]
		ifFalse:
			[theFP := self frameOfMarriedContext: callbackMethodContext.
			 framePointer = theFP "common case"
				ifTrue:
					[(self isBaseFrame: theFP)
						ifTrue: [stackPages freeStackPage: stackPage]
						ifFalse: "calloutMethodContext is immediately below on the same page.  Make it current."
							[instructionPointer := (self frameCallerSavedIP: framePointer) asUnsignedInteger.
							 stackPointer := framePointer + (self frameStackedReceiverOffset: framePointer) + objectMemory wordSize.
							 framePointer := self frameCallerFP: framePointer.
							 self setMethod: (self frameMethodObject: framePointer).
							 self restoreCStackStateForCallbackContext: vmCallbackContext.
							 "N.B. siglongjmp is defines as _longjmp on non-win32 platforms.
							  This matches the use of _setjmp in ia32abicc.c."
							 self siglong: vmCallbackContext trampoline jmp: (self integerValueOf: returnTypeOop).
							 ^true]]
				ifFalse:
					[self externalDivorceFrame: theFP andContext: callbackMethodContext.
					 self markContextAsDead: callbackMethodContext]].
	"Make the calloutMethodContext the active frame.  The case where calloutMethodContext
	 is immediately below callbackMethodContext on the same page is handled above."
	(self isStillMarriedContext: calloutMethodContext)
		ifTrue:
			[theFP := self frameOfMarriedContext: calloutMethodContext.
			 thePage := stackPages stackPageFor: theFP.
			 "findSPOf:on: points to the word beneath the instructionPointer, but
			  there is no instructionPointer on the top frame of the current page."
			 self assert: thePage ~= stackPage.
			 stackPointer := (self findSPOf: theFP on: thePage) - objectMemory wordSize.
			 framePointer := theFP]
		ifFalse:
			[thePage := self makeBaseFrameFor: calloutMethodContext.
			 framePointer := thePage headFP.
			 stackPointer := thePage headSP].
	instructionPointer := self popStack.
	self setMethod: (objectMemory fetchPointer: MethodIndex ofObject: calloutMethodContext).
	self setStackPageAndLimit: thePage.
	self restoreCStackStateForCallbackContext: vmCallbackContext.
	 "N.B. siglongjmp is defines as _longjmp on non-win32 platforms.
	  This matches the use of _setjmp in ia32abicc.c."
	self siglong: vmCallbackContext trampoline jmp: (self integerValueOf: returnTypeOop).
	"NOTREACHED"
	^true