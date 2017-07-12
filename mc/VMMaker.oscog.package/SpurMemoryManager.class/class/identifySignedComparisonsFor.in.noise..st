analysis
identifySignedComparisonsFor: options in: selectors noise: noise
	"self identify32BitSignedComparisonsInSegmentIO"
	"self identify64BitSignedComparisonsInSegmentIO"
	| vmm cg halt |
	halt := false.
	vmm := (VMMaker forPlatform: 'Cross')
				interpreterClass: StackInterpreter;
				options: options.
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
	selectors sort do:
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
					[halt ifTrue: [self halt: node printString].
					 Transcript ensureCr; nextPutAll: sel; space; print: node; flush]]]]