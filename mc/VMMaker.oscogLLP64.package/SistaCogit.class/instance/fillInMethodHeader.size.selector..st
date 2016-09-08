generate machine code
fillInMethodHeader: method size: size selector: selector
	super fillInMethodHeader: method size: size selector: selector.
	self fillInCounters: numCounters atStartAddress: counters.
	method counters: counters.
	^method