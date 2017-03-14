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
	self assert: primFailCode = 0.
	self assert: (objectMemory isIntegerObject: returnTypeOop).
	self assert: (objectMemory isImmediate: vmCallbackContext) not.
	self assert: ((objectMemory addressCouldBeObj: callbackMethodContext)
				and: [objectMemory isContext: callbackMethodContext]).
	self assert: (debugCallbackPath := 0) = 0.
	((objectMemory isIntegerObject: returnTypeOop)
	 and: [self isLiveContext: callbackMethodContext]) ifFalse:
		[self assert: (debugCallbackPath := 1) = 1.
		 ^false].
	calloutMethodContext := self externalInstVar: SenderIndex ofContext: callbackMethodContext.
	(self isLiveContext: calloutMethodContext) ifFalse:
		[self assert: (debugCallbackPath := 2) = 2.
		 ^false].
	self assert: (debugCallbackReturns := debugCallbackReturns + 1) > 0.
	"self assert: debugCallbackReturns < 3802."
	"We're about to leave this stack page; must save the current frame's instructionPointer."
	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	"Mark callbackMethodContext as dead; the common case is that it is the current frame.
	 We go the extra mile for the debugger."
	(self isSingleContext: callbackMethodContext)
		ifTrue:
			[self assert: (debugCallbackPath := debugCallbackPath bitOr: 4) > 0.
		 	 self markContextAsDead: callbackMethodContext]
		ifFalse:
			[self assert: (debugCallbackPath := debugCallbackPath bitOr: 8) > 0.
		 	 theFP := self frameOfMarriedContext: callbackMethodContext.
			 self assert: (self frameReceiver: theFP) = (objectMemory splObj: ClassAlien).
			 framePointer = theFP "common case"
				ifTrue:
					[self assert: (debugCallbackPath := debugCallbackPath bitOr: 16) > 0.
		 			 (self isBaseFrame: theFP) ifFalse: "calloutMethodContext is immediately below on the same page.  Make it current."
						[self assert: (debugCallbackPath := debugCallbackPath bitOr: 32) > 0.
		 				 instructionPointer := (self frameCallerSavedIP: theFP) asUnsignedInteger.
						 stackPointer := theFP + (self frameStackedReceiverOffset: theFP) + objectMemory wordSize.
						 framePointer := self frameCallerFP: theFP.
						 self setMethod: (self frameMethodObject: framePointer).
						 self restoreCStackStateForCallbackContext: vmCallbackContext.
						 self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer.
						 "N.B. siglongjmp is defines as _longjmp on non-win32 platforms.
						  This matches the use of _setjmp in ia32abicc.c."
						 self siglong: vmCallbackContext trampoline jmp: (self integerValueOf: returnTypeOop).
						 ^true].
					 stackPages freeStackPage: stackPage]
				ifFalse:
					[self assert: (debugCallbackPath := debugCallbackPath bitOr: 64) > 0.
		 			 self externalDivorceFrame: theFP andContext: callbackMethodContext.
					 self markContextAsDead: callbackMethodContext]].
	"Make the calloutMethodContext the active frame.  The case where calloutMethodContext
	 is immediately below callbackMethodContext on the same page is handled above."
	(self isStillMarriedContext: calloutMethodContext)
		ifTrue:
			[self assert: (debugCallbackPath := debugCallbackPath bitOr: 128) > 0.
		 	 theFP := self frameOfMarriedContext: calloutMethodContext.
			 thePage := stackPages stackPageFor: theFP.
			 "findSPOf:on: points to the word beneath the instructionPointer, but
			  there is no instructionPointer on the top frame of the current page."
			 self assert: thePage ~= stackPage.
			 stackPointer := thePage headFP = theFP
								ifTrue: [thePage headSP]
								ifFalse: [(self findSPOf: theFP on: thePage) - objectMemory wordSize].
			 framePointer := theFP.
			 self assert: stackPointer < framePointer]
		ifFalse:
			[self assert: (debugCallbackPath := debugCallbackPath bitOr: 256) > 0.
		 	 thePage := self makeBaseFrameFor: calloutMethodContext.
			 self setStackPointersFromPage: thePage].
	instructionPointer := self popStack.
	self setMethod: (objectMemory fetchPointer: MethodIndex ofObject: calloutMethodContext).
	self setStackPageAndLimit: thePage.
	self restoreCStackStateForCallbackContext: vmCallbackContext.
	primitiveFunctionPointer := vmCallbackContext savedPrimFunctionPointer.
	"N.B. siglongjmp is defined as _longjmp on non-win32 platforms.
	  This matches the use of _setjmp in ia32abicc.c."
	self siglong: vmCallbackContext trampoline jmp: (self integerValueOf: returnTypeOop).
	"NOTREACHED"
	^true