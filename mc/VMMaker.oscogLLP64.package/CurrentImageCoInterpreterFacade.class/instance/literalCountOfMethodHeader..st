accessing
literalCountOfMethodHeader: headerIntegerOop
	^(headerToMethodMap at: headerIntegerOop) numLiterals
	"a.k.a.
	^coInterpreter literalCountOfMethodHeader: aSmallIntegerOop,
	 but only if the CompiledMethod header formats match"