utilities
removeMethodForSelector: aSelector
	"Remove the given method from the code base"
	((breakSrcInlineSelectors includes: aSelector)
	 or: [(breakDestInlineSelectors includes: aSelector)]) ifTrue:
		[self halt].
	methods removeKey:  aSelector ifAbsent: []