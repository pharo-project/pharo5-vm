accessing
at: index put: value
	"The special handling of functionPointerIndex is necessary because in simulation function
	 pointers are Smalltalk symbols (under simulation primitive dispatch is done via perform:)."
	index - 1 \\ entrySize = functionPointerIndex ifTrue:
		[^methodCacheArray at: index put: value].
	^object at: index + offset put: value