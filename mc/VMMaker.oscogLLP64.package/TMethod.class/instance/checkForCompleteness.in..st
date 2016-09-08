inlining
checkForCompleteness: stmtLists in: aCodeGen
	"Set the complete flag if none of the given statement list nodes contains further candidates for inlining."

	complete := true.
	stmtLists do:
		[:stmtList|
		stmtList statements do:
			[:node|
			[(self inlineableSend: node in: aCodeGen) ifTrue:
				[complete := false.  "more inlining to do"
				^self]]]].

	parseTree
		nodesDo:
			[:node|
			(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
				[complete := false.  "more inlining to do"
				^self]]
		unless:
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]]