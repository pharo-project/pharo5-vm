page access
freeStackPageNoAssert: aPage "<InterpreterStackPage>"
	"MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"
	<var: #aPage type: #'StackPage *'>
	<returnTypeC: #void>
	| prev |
	<var: #prev type: #'StackPage *'>
	aPage baseFP: 0.
	aPage == mostRecentlyUsedPage ifTrue:
		[mostRecentlyUsedPage := mostRecentlyUsedPage prevPage.
		 ^nil].
	(prev := aPage prevPage) isFree ifTrue:
		[^nil].
	prev nextPage: aPage nextPage.
	aPage nextPage prevPage: prev.
	aPage nextPage: mostRecentlyUsedPage nextPage.
	mostRecentlyUsedPage nextPage prevPage: aPage.
	aPage prevPage: mostRecentlyUsedPage.
	mostRecentlyUsedPage nextPage: aPage