stack pages
newStackPage
	"MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"
	| lruOrFree |
	<var: #lruOrFree type: #'StackPage *'>
	<returnTypeC: #'StackPage *'>
	lruOrFree := stackPages mostRecentlyUsedPage nextPage.
	(stackPages isFree: lruOrFree) ifTrue:
		[^lruOrFree].
	self divorceFramesIn: lruOrFree.
	^lruOrFree