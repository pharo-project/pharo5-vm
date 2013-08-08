page access
stackPageAt: index pages: thePages
	"Answer the page for a page index.
	 N.B.  This is a zero-relative index."
	<cmacro: '(index,pages) ((pages) + (index))'>
	<returnTypeC: #'StackPage *'> "for Slang..."
	^thePages at: index + 1