inlining
maybeBreakForTestToInline: aNodeOrSelector in: aTMethod
	"convenient for debugging..."
	| selector |
	selector := aNodeOrSelector isSymbol
					ifTrue: [aNodeOrSelector]
					ifFalse:
						[aNodeOrSelector isSend
							ifTrue: [aNodeOrSelector selector]
							ifFalse: [^self]].
	(breakSrcInlineSelectors size + breakDestInlineSelectors size > 0
	and: [(breakSrcInlineSelectors isEmpty or: [breakSrcInlineSelectors includes: selector])
	and: [(breakDestInlineSelectors isEmpty or: [(breakDestInlineSelectors includes: aTMethod selector)])
	and: [breakOnInline ~~ true]]]) ifTrue:
		[aTMethod halt: aTMethod selector, ' ', selector]