debug printing
printStackPageListInUse
	| page |
	<inline: false>
	<var: #page type: #'StackPage *'>
	page := stackPages mostRecentlyUsedPage.
	[(stackPages isFree: page) ifFalse:
		[self printStackPage: page.
		 self cr].
	 (page := page prevPage) ~= stackPages mostRecentlyUsedPage] whileTrue