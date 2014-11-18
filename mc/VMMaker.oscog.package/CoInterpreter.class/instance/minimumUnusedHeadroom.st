debug support
minimumUnusedHeadroom
	"Traverse all stack pages looking for non-zero bytes in the headroom part of each page.
	 Answer the minimum size of unused headroom (zero bytes) in the pages.  This is for
	 checking that there is enough headroom allocated in stack pages."
	| minUnused page |
	<var: #page type: #'StackPage *'>
	<var: #p type: #'char *'>
	minUnused := (stackPages stackPageAt: 0) baseAddress - (stackPages stackPageAt: 0) lastAddress.
	0 to: numStackPages - 1 do:
		[:i| | p unused |
		page := stackPages stackPageAt: i.
		p := page lastAddress.
		[p := p + objectMemory wordSize.
		(self longAtPointer: p) = 0
		 and: [p <= page baseAddress]] whileTrue.
		unused := p - objectMemory wordSize - page lastAddress.
		unused < minUnused ifTrue:
			[minUnused := unused]].
	^minUnused