assertions
pageListIsWellFormed
	"Answer if the stack page list is well-formed.
	 MRUP-->used page<->used page<->used page<->used page<--LRUP
	               ^                        <-next-prev->                         ^
	                |                                                                       |
	                v                        <-prev-next->                         v
	                free page<->free page<->free page<->free page"
	| ok page count limit |
	<inline: false>
	<var: #page type: #'StackPage *'>
	ok := true.
	page := mostRecentlyUsedPage nextPage.
	count := 1.
	limit := numPages * 2.
	[page isFree
	 and: [page ~= mostRecentlyUsedPage
	 and: [count <= limit]]] whileTrue:
		[(self asserta: page nextPage prevPage == page) ifFalse:
			[ok := false].
		 page := page nextPage.
		 count := count + 1].
	[page ~= mostRecentlyUsedPage
	 and: [count <= limit]] whileTrue:
		[(self asserta: page nextPage prevPage == page) ifFalse:
			[ok := false].
		 (self asserta: page isFree not)
			ifTrue:
				[(self asserta: (self stackPageFor: page baseFP) == page) ifFalse:
					[ok := false].
				 (self asserta: (self stackPageFor: page headSP) == page) ifFalse:
					[ok := false]]
			ifFalse:
				[ok := false].
		 page := page nextPage.
		 count := count + 1].
	(self asserta: count = numPages) ifFalse:
		[ok := false].
	^ok