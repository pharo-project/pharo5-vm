analysis
identifySignedComparisonsFor: options noise: noise
	"self identify32BitSignedComparisons"
	"self identify64BitSignedComparisons"
	| vmm cg |
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