inlining
tryToInlineMethodExpressionsIn: aCodeGen
	"Expand any (complete) inline methods sent by this method as receivers or parameters.
	 Answer if anything was inlined."

	| sendsToInline |
	sendsToInline := Dictionary new: 100.
	parseTree
		nodesDo:
			[:node|
			(self transformConditionalAssignment: node in: aCodeGen) ifNotNil:
				[:replacement|
				 sendsToInline at: node put: replacement].
			(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
				[(self inlineFunctionCall: node in: aCodeGen) ifNotNil:
					[:replacement|
					 sendsToInline at: node put: replacement]]]
		unless: "Don't inline the arguments to asserts to keep the asserts readable"
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]].

	sendsToInline isEmpty ifTrue:
		[^false].
	parseTree := parseTree replaceNodesIn: sendsToInline.
	^true