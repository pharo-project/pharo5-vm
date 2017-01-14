allocation
attemptToShrink
	"Attempt to shrink memory after successfully reclaiming lots of memory."
	| freeSizeNow |
	freeSizeNow := self freeSize.
	(freeSizeNow > shrinkThreshold
	 and: [freeSizeNow > growHeadroom]) ifTrue:
		[self shrinkObjectMemory: freeSizeNow - growHeadroom]