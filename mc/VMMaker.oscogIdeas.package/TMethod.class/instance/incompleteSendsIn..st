inlining support
incompleteSendsIn: aCodeGen
	"Debugging support; answer the incomplete and inlineable sends in the receiver."
	| incompleteSends inlineableSends |
	aCodeGen maybeBreakForTestOfInliningOf: selector.

	incompleteSends := IdentitySet new.
	inlineableSends := IdentitySet new.

	parseTree
		nodesDo:
			[:node|
			 node isSend ifTrue:
				[(self methodIsEffectivelyComplete: node selector in: aCodeGen)
					ifTrue:
						[(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
							[inlineableSends add: node]]
					ifFalse:
						[incompleteSends add: node]]]
		unless:
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]].

	^{incompleteSends. inlineableSends}