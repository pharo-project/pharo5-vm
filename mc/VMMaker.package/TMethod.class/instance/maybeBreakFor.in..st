inlining
maybeBreakFor: aNode in: aCodeGen
	"convenient for debugging..."
	(aNode isSend
	and: [(aCodeGen breakSrcInlineSelector notNil or: [aCodeGen breakDestInlineSelector notNil])
	and: [(aCodeGen breakSrcInlineSelector ifNil: [true] ifNotNil: [:srcSel| srcSel = aNode selector])
	and: [aCodeGen breakDestInlineSelector ifNil: [true] ifNotNil: [:dstSel| dstSel = selector]]]]) ifTrue:
		[self halt: selector]