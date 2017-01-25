analysis
identifySignedComparisons
	"self identifySignedComparisons"
	| vmm cg noise |
	noise := #('(manager bytesInObject: largestFreeChunk) >= spaceEstimate'
				'(self classIndexOf: o*) > self isForwardedObjectClassIndexPun'
				'GCModeFull > 0'
				'ReceiverIndex + (objectMemory integerValueOf: sp*) < (objectMemory lengthOf: o*)'
				'availableSpace > 0'
				'bytes + 2 * 8 > availableSpace'
				'fmt* < manager firstCompiledMethodFormat'
				'fmt* < self firstCompiledMethodFormat'
				'fmt* <= 5'
				'gcPhaseInProgress > 0'
				'i <= finishIndex'
				'i >= 0'
				'numPointerSlots > 0'
				'scavenger rememberedSetSize > 0').
	vmm := (VMMaker forPlatform: 'Cross')
				interpreterClass: StackInterpreter;
				options: #(ObjectMemory Spur32BitMemoryManager).
	cg := [vmm buildCodeGeneratorForInterpreter]
			on: Notification
			do: [:ex|
				ex tag == #getVMMaker
					ifTrue: [ex resume: vmm]
					ifFalse: [ex pass]].
	cg vmClass preGenerationHook: cg.
	cg inferTypesForImplicitlyTypedVariablesAndMethods.
	cg retainMethods: self selectors.
	cg prepareMethods.
	cg doInlining: true.
	self selectors sort do:
		[:sel|
		(cg methodNamed: sel) ifNotNil:
			[:m|
			m parseTree nodesDo:
				[:node|
				(node isSend
				 and: [(#(< > <= >=) includes: node selector)
				 and: [({node receiver. node args first } anySatisfy:
						[:o| (cg typeFor: o in: m)
								ifNil: [true]
								ifNotNil: [:t| (cg isIntegralCType: t) and: [t first ~= $u]]])
				 and: [noise noneSatisfy: [:n| n match: node printString]]]]) ifTrue:
					[Transcript ensureCr; nextPutAll: sel; space; print: node; flush]]]]