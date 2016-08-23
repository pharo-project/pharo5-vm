disassembly
collectMapEntry: annotation address: mcpc into: aDictionary
	<doNotGenerate>
	aDictionary
		at: mcpc
		ifPresent:
			[:extant|
			aDictionary
				at: mcpc
				put: extant, ':\' withCRs, (self class annotationConstantNames at: annotation + 1)]
		ifAbsentPut: [self class annotationConstantNames at: annotation + 1].
	^0