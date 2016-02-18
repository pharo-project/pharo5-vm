debug printing
printStackPageListInUse
	| page n |
	<inline: false>
	<var: #page type: #'StackPage *'>
	page := stackPages mostRecentlyUsedPage.
	n := 0.
	[(stackPages isFree: page) ifFalse:
		[self printStackPage: page useCount: (n := n + 1); cr].
	 (page := page prevPage) ~= stackPages mostRecentlyUsedPage] whileTrue