debug printing
selectorOfContext: aContext
	(self isContext: aContext) ifFalse:
		[^nil].
	^self
		findSelectorOfMethod: (self fetchPointer: MethodIndex ofObject: aContext)
		forReceiver:  (self fetchPointer: ReceiverIndex ofObject: aContext)