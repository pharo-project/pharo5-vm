handler search
findMethodWithPrimitive: primitive FromContext: senderContext UpToContext: homeContext
	"See findUnwindThroughContext:.  Alas this is mutually recursive with
	 findMethodWithPrimitive:FromFP:SP:ThroughContext: instead of iterative.
	 We're doing the simplest thing that could possibly work.  Niceties can wait."
	<inline: false>
	<returnTypeC: #sqInt> "Being mutually-recursive with findMethodWithPrimitive:FromFP:UpToContext: gives the author's type inference algorithm headaches.  Wimp out by declaring the return type."
	| theContext theMethod |
	self assert: (senderContext = objectMemory nilObject or: [objectMemory isContext: senderContext]).
	self assert: (homeContext = objectMemory nilObject or: [objectMemory isContext: homeContext]).
	theContext := senderContext.
	[theContext = objectMemory nilObject ifTrue:
		[^theContext].
	 self isMarriedOrWidowedContext: theContext] whileFalse:
		[theContext = homeContext ifTrue: [^0].
		 (primitive = 0
		  or: [(objectMemory fetchPointer: ClosureIndex ofObject: theContext) ~= objectMemory nilObject]) ifFalse:
		 	[theMethod := objectMemory fetchPointer: MethodIndex ofObject: theContext.
			 (self primitiveIndexOf: theMethod) = primitive ifTrue:
				[^theContext]].
		 theContext := objectMemory fetchPointer: SenderIndex ofObject: theContext].
	(self isWidowedContext: theContext) ifTrue:
		[^objectMemory nilObject].
	^self
		findMethodWithPrimitive: primitive
		FromFP: (self frameOfMarriedContext: theContext)
		UpToContext: homeContext