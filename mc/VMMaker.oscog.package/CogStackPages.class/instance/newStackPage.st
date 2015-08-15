page access
newStackPage
	"MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"
	<returnTypeC: #'StackPage *'>
	| lruOrFree |
	<var: #lruOrFree type: #'StackPage *'>
	lruOrFree := mostRecentlyUsedPage nextPage.
	lruOrFree isFree ifTrue:
		[^lruOrFree].
	coInterpreter divorceFramesIn: lruOrFree.
	^lruOrFree