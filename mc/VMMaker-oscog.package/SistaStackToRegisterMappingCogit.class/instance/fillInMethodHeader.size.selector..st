generate machine code
fillInMethodHeader: method size: size selector: selector
	super fillInMethodHeader: method size: size selector: selector.
	method numCounters: counterIndex.
	^method