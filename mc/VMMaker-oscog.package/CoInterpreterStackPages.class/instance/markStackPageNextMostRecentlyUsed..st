page access
markStackPageNextMostRecentlyUsed: page "<InterpreterStackPage>"
	"This method is used to move a page to a position in the list such that it cannot
	 be deallocated when a new page is allocated, without changing the most recently
	 used page.  There must be at least 3 pages in the system.  So making the page
	 the MRU's prevPage is sufficient to ensure it won't be deallocated."

	"MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"

	<var: #page type: #'StackPage *'>
	<returnTypeC: #void>
	self assert: page ~~ mostRecentlyUsedPage.
	page nextPage == mostRecentlyUsedPage ifTrue:
		[^nil].
	page prevPage nextPage: page nextPage.
	page nextPage prevPage: page prevPage.
	mostRecentlyUsedPage prevPage nextPage: page.
	page prevPage: mostRecentlyUsedPage prevPage.
	page nextPage: mostRecentlyUsedPage.
	mostRecentlyUsedPage prevPage: page.
	self assert: self pageListIsWellFormed