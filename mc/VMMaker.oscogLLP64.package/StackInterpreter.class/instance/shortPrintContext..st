debug printing
shortPrintContext: aContext
	| theFP |
	<inline: false>
	<var: #theFP type: #'char *'>
	(objectMemory isContext: aContext) ifFalse:
		[self printHex: aContext; print: ' is not a context'; cr.
		^nil].
	self printHex: aContext.
	(self isMarriedOrWidowedContext: aContext)
		ifTrue: [(self checkIsStillMarriedContext: aContext currentFP: framePointer)
					ifTrue:
						[(self isMachineCodeFrame: (theFP := self frameOfMarriedContext: aContext))
							ifTrue: [self print: ' M (']
							ifFalse: [self print: ' I ('].
						 self printHex: theFP asUnsignedInteger; print: ') ']
					ifFalse:
						[self print: ' w ']]
		ifFalse: [self print: ' s '].
	(self findHomeForContext: aContext)
		ifNil: [self print: ' BOGUS CONTEXT (can''t determine home)']
		ifNotNil:
			[:home|
			 self printActivationNameFor: (objectMemory
											fetchPointer: MethodIndex
											ofObject: (home ifNil: [aContext]))
				receiver: (home
							ifNil: [objectMemory nilObject]
							ifNotNil: [objectMemory fetchPointer: ReceiverIndex ofObject: home])
				isBlock: home ~= aContext
				firstTemporary: (objectMemory fetchPointer: 0 + CtxtTempFrameStart ofObject: home)].
	self cr