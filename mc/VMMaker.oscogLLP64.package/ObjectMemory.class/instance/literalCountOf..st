method access
literalCountOf: methodPointer
	<api>
	^self literalCountOfMethodHeader: (self methodHeaderOf: methodPointer)