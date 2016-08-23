handler search
findMethodWithPrimitive: primitive FromFP: startFP UpToContext: homeContext
	"See findUnwindThroughContext:.  Alas this is mutually recursive with
	 findMethodWithPrimitive:FromContext:ThroughContext: instead of iterative.
	 We're doing the simplest thing that could possibly work.  Niceties can wait."
	<inline: true>
	| theFP theFPAbove theSP theMethod senderContext |
	<var: #startFP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #theFPAbove type: #'char *'>
	<var: #theSP type: #'char *'>
	theFP := startFP.
	theFPAbove := startFP.
	[((self frameHasContext: theFP)
	  and: [homeContext = (self frameContext: theFP)]) ifTrue:
		[^0].
	 (primitive = 0
	  or: [self frameIsBlockActivation: theFP]) ifFalse:
	 	[theMethod := self frameMethodObject: theFP.
		 (self primitiveIndexOf: theMethod) = primitive ifTrue:
			[theFP = theFPAbove
						ifTrue: [theSP := self findSPOf: theFP on: (stackPages stackPageFor: theFP)]
						ifFalse: [theSP := self frameCallerStackPointer: theFPAbove].
			 ^self ensureFrameIsMarried: theFP SP: theSP]].
	 theFPAbove := theFP.
	 theFP := self frameCallerFP: theFP.
	 theFP ~= 0] whileTrue.
	senderContext := self frameCallerContext: theFPAbove.
	(objectMemory isContext: senderContext) ifFalse:
		[^objectMemory nilObject].
	^self
		findMethodWithPrimitive: primitive
		FromContext: senderContext
		UpToContext: homeContext