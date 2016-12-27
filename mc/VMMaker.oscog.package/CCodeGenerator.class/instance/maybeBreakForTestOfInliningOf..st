inlining
maybeBreakForTestOfInliningOf: aNodeOrSelector
	"convenient for debugging..."
	| selector |
	selector := aNodeOrSelector isSymbol
					ifTrue: [aNodeOrSelector]
					ifFalse:
						[aNodeOrSelector isSend
							ifTrue: [aNodeOrSelector selector]
							ifFalse: [^self]].
	((breakSrcInlineSelectors includes: selector)
	 and: [breakDestInlineSelectors isEmpty
	 and: [breakOnInline == true]]) ifTrue:
		[self halt: selector]