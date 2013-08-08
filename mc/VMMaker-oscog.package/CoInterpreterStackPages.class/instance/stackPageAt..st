page access
stackPageAt: index
	"Answer the page for a page index.
	 N.B.  This is a zero-relative index."
	<returnTypeC: #'StackPage *'>
	^self stackPageAt: index pages: pages