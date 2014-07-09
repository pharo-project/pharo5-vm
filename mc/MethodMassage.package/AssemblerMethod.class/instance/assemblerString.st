printing
assemblerString
	^String streamContents: [:s| self printAsAssemblerOn: s]