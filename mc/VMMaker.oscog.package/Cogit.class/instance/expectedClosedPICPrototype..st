garbage collection
expectedClosedPICPrototype: cPIC
	"Answer 0 if the ClosedPIC is as expected from compileClosedPICPrototype,
	 otherwise answer an error code identifying the first discrepancy found."
	<var: #cPIC type: #'CogMethod *'>
	| pc offsetToLiteral object entryPoint |
	pc := cPIC asInteger + firstCPICCaseOffset.
	"First jump is unconditional; subsequent ones are conditional"
	offsetToLiteral := backEnd jumpLongByteSize.
	1 to: numPICCases do:
		[:i|
		i > 1 ifTrue:
			[object := literalsManager classRefInClosedPICAt: pc - offsetToLiteral.
			 object = (16rBABE1F15 + i - 1) ifFalse:
				[^1]].
		object := literalsManager objRefInClosedPICAt: pc - offsetToLiteral.
		object = (i = 1
					ifTrue: [16r5EAF00D]
					ifFalse: [16rBADA550 + i - 1]) ifFalse:
			[^2].
		offsetToLiteral := backEnd jumpLongConditionalByteSize.
		entryPoint := literalsManager cPICCase: i jumpTargetBefore: pc.
		entryPoint = (self cPICPrototypeCaseOffset + 16rCA5E10 + (i - 1 * 16)) ifFalse:
				[^3].
		pc := pc + cPICCaseSize].
	pc := pc - cPICCaseSize.
	entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc + cPICEndSize.
	entryPoint = (self cPICMissTrampolineFor: 0) ifFalse:
		[^4].
	^0