debug printing
shortPrintFramesOnStackPageListInUse
	<export: true>
	| page |
	<inline: false>
	<var: #page type: #'StackPage *'>
	page := stackPages mostRecentlyUsedPage.
	[(stackPages isFree: page) ifFalse:
		[self print: 'page '; printHexPtrnp: (self cCode: [page] inSmalltalk: [page baseAddress]); cr.
		 self shortPrintFramesInPage: page.
		 self cr].
	 (page := page prevPage) ~= stackPages mostRecentlyUsedPage] whileTrue