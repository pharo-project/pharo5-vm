page access
pageIndexFor: pointer "<Integer>"
	"Answer the page index for a pointer into stack memory, i.e. the index
	 for the page the address is in.  N.B.  This is a zero-relative index."
	<var: #pointer type: #'void *'>
	<inline: true>
	self assert: ((self cCoerceSimple: pointer to: #'char *')
					between: stackBasePlus1 - 1
					and: (self cCode: [self cCoerceSimple: pages to: #'char *']
							inSmalltalk: [(self stackPageAt: 0) asInteger])).
	^self pageIndexFor: pointer stackBasePlus1: stackBasePlus1 bytesPerPage: bytesPerPage