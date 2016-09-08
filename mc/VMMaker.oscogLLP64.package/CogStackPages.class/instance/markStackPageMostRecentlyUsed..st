page access
markStackPageMostRecentlyUsed: page "<InterpreterStackPage>"
	"MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"
	<var: #page type: #'StackPage *'>
	<returnTypeC: #void>
	page == mostRecentlyUsedPage ifTrue:
		[^nil].
	"Common case; making new page most recently used."
	page prevPage == mostRecentlyUsedPage ifTrue:
		[mostRecentlyUsedPage := page.
		 self assert: self pageListIsWellFormed.
		 ^nil].
	page prevPage nextPage: page nextPage.
	page nextPage prevPage: page prevPage.
	mostRecentlyUsedPage nextPage prevPage: page.
	page prevPage: mostRecentlyUsedPage.
	page nextPage: mostRecentlyUsedPage nextPage.
	mostRecentlyUsedPage nextPage: page.
	mostRecentlyUsedPage := page.
	self assert: self pageListIsWellFormed