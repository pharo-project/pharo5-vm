page access
freeStackPageNoAssert: aPage "<InterpreterStackPage>"
	"MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"
	| prev |
	<var: #aPage type: #'StackPage *'>
	<var: #prev type: #'StackPage *'>
	aPage baseFP: 0.
	aPage == mostRecentlyUsedPage ifTrue:
		[mostRecentlyUsedPage := mostRecentlyUsedPage prevPage.
		 ^nil].
	"lack of type inferrence means ``self isFree: aPage prevPage''
	 isn't turned into a direct field test; sigh..."
	prev := aPage prevPage.
	(self isFree: prev) ifTrue:
		[^nil].
	prev nextPage: aPage nextPage.
	aPage nextPage prevPage: prev.
	aPage nextPage: mostRecentlyUsedPage nextPage.
	mostRecentlyUsedPage nextPage prevPage: aPage.
	aPage prevPage: mostRecentlyUsedPage.
	mostRecentlyUsedPage nextPage: aPage