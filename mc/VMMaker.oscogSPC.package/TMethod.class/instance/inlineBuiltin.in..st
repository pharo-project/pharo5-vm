inlining
inlineBuiltin: aSendNode in: aCodeGen
	| sel meth inlinedReplacement |
	(aSendNode selector beginsWith: 'perform:') ifTrue:
		[^self inlineFunctionCall: aSendNode asTransformedConstantPerform in: aCodeGen].
	sel := aSendNode receiver selector.
	meth := aCodeGen methodNamed: sel.
	(meth notNil and: [meth inline == true]) ifFalse: [^nil].
	(meth isFunctionalIn: aCodeGen) ifTrue:
		[inlinedReplacement := (aCodeGen methodNamed: aSendNode receiver selector) copy
									inlineFunctionCall: aSendNode receiver
									in: aCodeGen.
		 ^TSendNode new
			setSelector: aSendNode selector
			receiver: inlinedReplacement
			arguments: aSendNode args copy].
	(self isInlineableConditional: aSendNode in: aCodeGen) ifTrue:
		[^self inlineConditional: aSendNode in: aCodeGen].
	^nil