accessing
temporaryCountOfMethodHeader: headerIntegerOop
	^(headerToMethodMap at: headerIntegerOop) numTemps
	"a.k.a.
	^coInterpreter temporaryCountOfMethodHeader: headerIntegerOop,
	 but only if the CompiledMethod header formats match"