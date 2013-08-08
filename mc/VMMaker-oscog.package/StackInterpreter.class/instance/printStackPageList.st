debug printing
printStackPageList
	| page |
	<inline: false>
	<var: #page type: #'StackPage *'>
	page := stackPages mostRecentlyUsedPage.
	[self printStackPage: page.
	 self cr.
	 (page := page prevPage) ~= stackPages mostRecentlyUsedPage] whileTrue