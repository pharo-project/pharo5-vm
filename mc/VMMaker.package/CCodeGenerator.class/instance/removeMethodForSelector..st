utilities
removeMethodForSelector: aSelector
	"Remove the given method from the code base"
	(breakSrcInlineSelector == aSelector
	 or: [breakDestInlineSelector == aSelector]) ifTrue:
		[self halt].
	methods removeKey:  aSelector ifAbsent: []