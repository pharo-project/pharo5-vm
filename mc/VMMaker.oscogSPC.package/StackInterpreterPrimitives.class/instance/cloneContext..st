primitive support
cloneContext: aContext 
	| sz cloned spouseFP sp |
	<var: #spouseFP type: #'char *'>
	sz := objectMemory numSlotsOf: aContext.
	cloned := objectMemory eeInstantiateMethodContextSlots: sz.
	cloned ~= 0 ifTrue:
		[0 to: StackPointerIndex do:
			[:i|
			objectMemory
				storePointerUnchecked: i
				ofObject: cloned
				withValue: (self externalInstVar: i ofContext: aContext)].
		MethodIndex to: ReceiverIndex do:
			[:i|
			objectMemory
				storePointerUnchecked: i
				ofObject: cloned
				withValue: (self fetchPointer: i ofObject: aContext)].
		(self isStillMarriedContext: aContext)
			ifTrue:
				[spouseFP := self frameOfMarriedContext: aContext.
				 sp := (self stackPointerIndexForFrame: spouseFP) - 1.
				 0 to: sp do:
					[:i|
					objectMemory
						storePointerUnchecked: i + CtxtTempFrameStart
						ofObject: cloned
						withValue: (self temporary: i in: spouseFP)]]
			ifFalse:
				[sp := (self fetchStackPointerOf: aContext) - 1.
				 0 to: sp do:
					[:i|
					objectMemory
						storePointerUnchecked: i + CtxtTempFrameStart
						ofObject: cloned
						withValue: (self fetchPointer: i + CtxtTempFrameStart ofObject: aContext)]]].
	^cloned