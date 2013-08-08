inlining
shouldExpand
	^(statements detect: [:stmt| stmt isInline]) shouldExpand