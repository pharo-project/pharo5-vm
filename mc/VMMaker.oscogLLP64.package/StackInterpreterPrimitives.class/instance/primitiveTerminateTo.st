control primitives
primitiveTerminateTo
	"Primitive. Terminate up the context stack from the receiver up to but not including
	 the argument, if previousContext is on my Context stack. Make previousContext my
	 sender. This prim has to shadow the code in ContextPart>terminateTo: to be correct."
	| thisCtx currentCtx aContextOrNil contextsFP contextsSP contextsIP nextCntx stackedReceiverOffset 
	  theFP newFP newSP pageToStopOn thePage frameAbove |
	<var: #contextsFP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #newFP type: #'char *'>
	<var: #newSP type: #'char *'>
	<var: #contextsIP type: #usqInt>
	<var: #frameAbove type: #'char *'>
	<var: #contextsSP type: #'char *'>
	<var: #source type: #'char *'>
	<var: #pageToStopOn type: #'StackPage *'>
	<var: #thePage type: #'StackPage *'>

	aContextOrNil := self stackTop.
	(aContextOrNil = objectMemory nilObject or: [objectMemory isContext: aContextOrNil]) ifFalse:
		[^self primitiveFail].
	thisCtx := self stackValue: 1.
	thisCtx = aContextOrNil ifTrue:
		[^self primitiveFail].		

	"All stackPages need to have current head pointers to avoid confusion."
	self externalWriteBackHeadFramePointers.

	"If we're searching for aContextOrNil it might be on a stack page.  Helps to know
	 if we can free a whole page or not, or if we can short-cut the termination."
	(aContextOrNil ~= objectMemory nilObject and: [self isStillMarriedContext: aContextOrNil])
		ifTrue: [contextsFP := self frameOfMarriedContext: aContextOrNil.
				pageToStopOn := stackPages stackPageFor: contextsFP]
		ifFalse: [pageToStopOn := 0].

	"if thisCtx is married ensure it is a base frame.  Then we can assign its sender."
	(self isStillMarriedContext: thisCtx)
		ifTrue:
			[theFP := self frameOfMarriedContext: thisCtx.
			 "Optimize terminating thisContext.  Move its frame down to be next to
			  aContextOrNil's frame. Common in the exception system and so helps to be fast."
			 (theFP = framePointer
			  and: [pageToStopOn = stackPage]) ifTrue:
				[(self frameCallerFP: theFP) ~= contextsFP ifTrue:
					[stackedReceiverOffset := self frameStackedReceiverOffset: theFP.
					 frameAbove := self findFrameAbove: contextsFP inPage: pageToStopOn.
					 contextsIP := (self frameCallerSavedIP: frameAbove) asUnsignedInteger.
					 newSP := self frameCallerSP: frameAbove.
					 newFP := newSP - stackedReceiverOffset - objectMemory wordSize.
					 theFP + stackedReceiverOffset
						to: stackPointer
						by: objectMemory wordSize negated
						do: [:source|
							newSP := newSP - objectMemory wordSize.
							stackPages longAt: newSP put: (stackPages longAt: source)].
					 stackPages longAt: newFP + FoxSavedFP put: contextsFP.
					 stackPages longAt: newFP + FoxCallerSavedIP put: contextsIP.
					 self assert: (objectMemory isContext: thisCtx).
					 objectMemory storePointerUnchecked: SenderIndex
						ofObject: thisCtx
						withValue: (self withSmallIntegerTags: newFP).
					 objectMemory storePointerUnchecked: InstructionPointerIndex
						ofObject: thisCtx
						withValue: (self withSmallIntegerTags: contextsFP).
					 framePointer := newFP.
					 stackPointer := newSP].
				self pop: 1.
				self assert: stackPage = stackPages mostRecentlyUsedPage.
				^nil].
			 theFP := self externalEnsureIsBaseFrame: theFP. "May cause a GC!!"
			 currentCtx := self frameCallerContext: theFP.
			 "May also reclaim aContextOrNil's page, hence..."
			 (aContextOrNil ~= objectMemory nilObject and: [self isStillMarriedContext: aContextOrNil])
				ifTrue: [contextsFP := self frameOfMarriedContext: aContextOrNil.
						pageToStopOn := stackPages stackPageFor: contextsFP]
				ifFalse: [pageToStopOn := 0]]
		ifFalse:
			[currentCtx := objectMemory fetchPointer: SenderIndex ofObject: thisCtx].

	(self context: thisCtx hasSender: aContextOrNil) ifTrue:
		["Need to walk the stack freeing stack pages and nilling contexts."
		[currentCtx = aContextOrNil
		 or: [currentCtx = objectMemory nilObject]] whileFalse:
			[self assert: (objectMemory isContext: currentCtx).
			 (self isMarriedOrWidowedContext: currentCtx)
				ifTrue:
					[theFP := self frameOfMarriedContext: currentCtx.
					thePage := stackPages stackPageFor: theFP.
					"If externalEnsureIsBaseFrame: above has moved thisContext to its own stack
					 then we will always terminate to a frame on a different page.  But if we are
					 terminating some other context to a context somewhere on the current page
					 we must save the active frames above that context.  Things will look e.g. like this:
		thisCtx			499383332 s MethodContext(ContextPart)>resume:
						499380484 s BlockClosure>ensure:
						499377320 s MethodContext(ContextPart)>handleSignal:
						499373760 s MethodContext(ContextPart)>handleSignal:
						499372772 s MessageNotUnderstood(Exception)>signal
						499369068 s CodeSimulationTests(Object)>doesNotUnderstand: absentMethod
						499368708 s [] in CodeSimulationTests>testDNU
							(sender is 0xbffc2480 I CodeSimulationTests>runSimulated:)
						------------
		framePointer	0xbffc234c M MethodContext(ContextPart)>doPrimitive:method:receiver:args:
						0xbffc2378 M MethodContext(ContextPart)>tryPrimitiveFor:receiver:args:
						0xbffc23ac M MethodContext(ContextPart)>send:to:with:super:
						0xbffc23e4 M MethodContext(ContextPart)>send:super:numArgs:
						0xbffc2418 M MethodContext(InstructionStream)>interpretNextInstructionFor:
						0xbffc2434 M MethodContext(ContextPart)>step
						0xbffc2458 I MethodContext(ContextPart)>runSimulated:contextAtEachStep:
						------------
(499368708's sender)	0xbffc2480 I CodeSimulationTests>runSimulated:
						0xbffc249c M CodeSimulationTests>testDNU
						0xbffc24bc I CodeSimulationTests(TestCase)>performTest
						0xbffc24dc I [] in CodeSimulationTests(TestCase)>runCase
		aContextOrNil	0xbffc24fc M BlockClosure>ensure:
						0xbffc2520 I CodeSimulationTests(TestCase)>runCase
						0xbffc253c M [] in TestResult>runCase:
					When we find this case we move the frames above to a new page by making the
					frame above currentCtx a base frame, i.e. making 0xbffc2458 in the above example
					a base frame.  But in this iteration of the loop we don't move down a frame i.e. currentCtx
					doesn't change on this iteration."
					thePage = stackPage
						ifTrue:
							[frameAbove := self findFrameAbove: theFP inPage: thePage.
							self assert: frameAbove ~= 0.
							frameAbove := self externalEnsureIsBaseFrame: frameAbove. "May cause a GC!! May also reclaim aContextOrNil's page, hence..."
							(aContextOrNil ~= objectMemory nilObject and: [self isStillMarriedContext: aContextOrNil])
								ifTrue: [contextsFP := self frameOfMarriedContext: aContextOrNil.
										pageToStopOn := stackPages stackPageFor: contextsFP]
								ifFalse: [pageToStopOn := 0]]
						ifFalse:
							[thePage = pageToStopOn
								ifTrue:
									["We're here.  Cut back the stack to aContextOrNil's frame,
									  push its instructionPointer if it's not already a head frame,
									  and we're done."
									 frameAbove := self findFrameAbove: contextsFP inPage: thePage.
									 frameAbove ~= 0 ifTrue:
										[contextsSP := (self frameCallerSP: frameAbove) - objectMemory wordSize.
										 stackPages longAt: contextsSP put: (self frameCallerSavedIP: frameAbove).
										 self setHeadFP: contextsFP andSP: contextsSP inPage: thePage].
									 currentCtx := aContextOrNil]
								ifFalse:
									["We can free the entire page without further ado."
									 currentCtx := self frameCallerContext: thePage baseFP.
									 "for a short time invariant is violated; assert follows"
									 stackPages freeStackPageNoAssert: thePage]]]
				ifFalse:
					[nextCntx := objectMemory fetchPointer: SenderIndex ofObject: currentCtx.
					 self markContextAsDead: currentCtx.
					 currentCtx := nextCntx]]].
	self assert: stackPages pageListIsWellFormed.
	(self isMarriedOrWidowedContext: thisCtx)
		ifTrue:
			[self assert: (self checkIsStillMarriedContext: thisCtx currentFP: framePointer).
			 self assert: (self isBaseFrame: (self frameOfMarriedContext: thisCtx)).
			 theFP := self frameOfMarriedContext: thisCtx.
			 self frameCallerContext: theFP put: aContextOrNil]
		ifFalse: [objectMemory storePointer: SenderIndex ofObject: thisCtx withValue: aContextOrNil].
	self pop: 1.
	self assert: stackPage = stackPages mostRecentlyUsedPage