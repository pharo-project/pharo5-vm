debug printing
printStackPageListInUse
	| page n |
	<inline: false>
	<var: #page type: #'StackPage *'>
	page := stackPages mostRecentlyUsedPage.
	n := 0.
	[(stackPages isFree: page) ifFalse:
		[self printStackPage: page useCount: n; cr.
		 n := n + 1].
	 (page := page prevPage) ~= stackPages mostRecentlyUsedPage] whileTrue