accessing
argumentCountOfMethodHeader: headerIntegerOop
	^(headerToMethodMap at: headerIntegerOop) numArgs
	"a.k.a.
	^coInterpreter argumentCountOfMethodHeader: headerIntegerOop,
	 but only if the CompiledMethod header formats match"