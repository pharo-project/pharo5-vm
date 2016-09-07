control primitives
primitiveFindNextUnwindContext
	"Primitive. Search up the context stack for the next method context marked for unwind
	 handling from the receiver up to but not including the argument. Return nil if none found."
	| stopContext calleeContext handlerOrNilOrZero |
	<var: #theFP type: #'char *'>
	stopContext := self stackTop.
	calleeContext := self stackValue: 1.
	(stopContext = objectMemory nilObject or: [objectMemory isContext: stopContext]) ifFalse:
		[^self primitiveFail].
	"The following should never be true, but developing full blocks, early in September
	 2016 we were seeing invalid invocations of this primitive..  Hence the assert:"
	self assert: stopContext ~= calleeContext.
	self externalWriteBackHeadFramePointers.
	(self isStillMarriedContext: calleeContext)
		ifTrue:
			[| theFP |
			 theFP := self frameOfMarriedContext: calleeContext.
			 (self isBaseFrame: theFP)
				ifTrue:
					[handlerOrNilOrZero := self findMethodWithPrimitive: 198
												FromContext: (self frameCallerContext: theFP)
												UpToContext: stopContext]
				ifFalse:
					[handlerOrNilOrZero :=  self findMethodWithPrimitive: 198
												FromFP: (self frameCallerFP: theFP)
												UpToContext: stopContext]]
		ifFalse:
			[| startContext |
			 startContext := objectMemory fetchPointer: SenderIndex ofObject: calleeContext.
			 (objectMemory isContext: startContext)
				ifTrue:
					[handlerOrNilOrZero := self findMethodWithPrimitive: 198
												FromContext: startContext
												UpToContext: stopContext]
				ifFalse:
					[handlerOrNilOrZero := 0]].
	handlerOrNilOrZero = 0 ifTrue:
		[handlerOrNilOrZero := objectMemory nilObject].
	self pop: 2 thenPush: handlerOrNilOrZero