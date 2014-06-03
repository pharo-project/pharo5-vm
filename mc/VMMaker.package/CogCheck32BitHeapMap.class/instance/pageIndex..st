accessing
pageIndex: address
	^(address bitShift: PageShift) + 1 "32 - (pageSize log: 2)"