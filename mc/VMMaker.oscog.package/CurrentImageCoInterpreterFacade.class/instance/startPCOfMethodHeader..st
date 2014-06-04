accessing
startPCOfMethodHeader: aSmallIntegerOop
	^(headerToMethodMap at: aSmallIntegerOop) initialPC - 1