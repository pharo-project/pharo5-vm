page access
freeStackPage: aPage "<InterpreterStackPage>"
	"MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"
	<var: #aPage type: #'StackPage *'>
	<inline: false>
	self freeStackPageNoAssert: aPage.
	self assert: self pageListIsWellFormed