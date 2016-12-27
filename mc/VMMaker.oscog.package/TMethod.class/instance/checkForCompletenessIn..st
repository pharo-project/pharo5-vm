inlining support
checkForCompletenessIn: aCodeGen
	"Set the complete flag if the parse tree contains no further candidates for inlining."
	| foundIncompleteSend incompleteSends |
	aCodeGen maybeBreakForTestOfInliningOf: selector.

	foundIncompleteSend := false.
	incompleteSends := IdentitySet new.

	parseTree
		nodesDo:
			[:node|
			 node isSend ifTrue:
				[(self methodIsEffectivelyComplete: node selector in: aCodeGen)
					ifTrue:
						[(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
							[complete := false.  "more inlining to do"
							^self]]
					ifFalse:
						[foundIncompleteSend := true.
						 incompleteSends add: node]]]
		unless:
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]].

	foundIncompleteSend ifFalse:
		[complete := true]