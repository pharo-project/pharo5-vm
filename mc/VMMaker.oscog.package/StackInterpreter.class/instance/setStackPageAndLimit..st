stack pages
setStackPageAndLimit: thePage
	"Set stackPage to a different page.  Set stackLimit unless it has
	 been smashed.  Make the stackPage the most recently used"
	<inline: true>
	<var: #thePage type: #'StackPage *'>
	self assert: thePage ~= 0.
	stackPage := thePage.
	stackLimit ~= self allOnesAsCharStar ifTrue:
		[stackLimit := stackPage stackLimit].
	stackPages markStackPageMostRecentlyUsed: thePage