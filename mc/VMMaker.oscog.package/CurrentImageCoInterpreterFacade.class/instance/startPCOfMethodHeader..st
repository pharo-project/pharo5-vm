accessing
startPCOfMethodHeader: headerIntegerOop
	^(headerToMethodMap at: headerIntegerOop) initialPC - 1
	"a.k.a.
	^coInterpreter startPCOfMethodHeader: headerIntegerOop,
	 but only if the CompiledMethod header formats match"