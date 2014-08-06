compiled methods
literalCountOfHeader: headerPointer
	<api>
	"We support two method header formats, as selected by the sign flag.  Even if the VM only
	 has one bytecode set, supporting teh two formats here allows for instantiating methods in
	 the other format for testing, etc."
	^(self headerIndicatesAlternateBytecodeSet: headerPointer)
		ifTrue: [self literalCountOfAlternateHeader: headerPointer]
		ifFalse: [self literalCountOfOriginalHeader: headerPointer]