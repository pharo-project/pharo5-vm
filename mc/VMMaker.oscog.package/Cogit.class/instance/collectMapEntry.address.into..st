disassembly
collectMapEntry: annotation address: mcpc into: aDictionary
	<doNotGenerate>
	aDictionary at: mcpc put: (self class annotationConstantNames at: annotation + 1).
	^0