process primitive support
wakeHighestPriority
	"Return the highest priority process that is ready to run."
	"Note: It is a fatal VM error if there is no runnable process."
	| schedLists p processList |
	schedLists := self fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	p := self numSlotsOf: schedLists.
	p := p - 1.
	"index of last indexable field"
	processList := self fetchPointer: p ofObject: schedLists.
	[self isEmptyList: processList]
		whileTrue: [p := p - 1.
			p < 0 ifTrue: [self error: 'scheduler could not find a runnable process'].
			processList := self fetchPointer: p ofObject: schedLists].
	^ self removeFirstLinkOfList: processList