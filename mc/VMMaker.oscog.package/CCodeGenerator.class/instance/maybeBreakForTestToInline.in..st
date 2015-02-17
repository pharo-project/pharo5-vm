inlining
maybeBreakForTestToInline: aNode in: aTMethod
	"convenient for debugging..."
	(aNode isSend
	and: [(breakSrcInlineSelector notNil or: [breakDestInlineSelector notNil])
	and: [(breakSrcInlineSelector ifNil: [true] ifNotNil: [:srcSel| srcSel = aNode selector])
	and: [breakDestInlineSelector ifNil: [true] ifNotNil: [:dstSel| dstSel = aTMethod selector
	and: [breakOnInline ~~ true]]]]]) ifTrue:
		[aTMethod halt: aTMethod selector, ' ', aNode selector]