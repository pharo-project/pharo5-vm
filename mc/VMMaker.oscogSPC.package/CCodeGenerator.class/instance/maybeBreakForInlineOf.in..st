inlining
maybeBreakForInlineOf: aNode in: aTMethod
	"convenient for debugging..."
	(aNode isSend
	and: [breakSrcInlineSelectors size + breakDestInlineSelectors size > 0
	and: [(breakSrcInlineSelectors isEmpty or: [breakSrcInlineSelectors includes: aNode selector])
	and: [(breakDestInlineSelectors isEmpty or: [(breakDestInlineSelectors includes: aTMethod selector)])
	and: [breakOnInline ~~ false]]]]) ifTrue:
		[aTMethod halt: aTMethod selector, ' ', aNode selector]