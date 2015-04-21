accessing
startPCOfMethodHeader: aSmallIntegerOop
	"a.k.a. (headerToMethodMap at: aSmallIntegerOop) initialPC - 1"
	^coInterpreter startPCOfMethodHeader: aSmallIntegerOop