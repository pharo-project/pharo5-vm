page access
pageIndexFor: pointer "<Integer>"
	"Answer the page index for a pointer into stack memory, i.e. the index
	 for the page the address is in.  N.B.  This is a zero-relative index."
	<var: #pointer type: #'void *'>
	<inline: true>
	self subclassResponsibility