initialization
initializeStart: aStart limit: aLimit
	self start: aStart;
		limit: aLimit;
		first: aStart;
		last: aStart - manager wordSize