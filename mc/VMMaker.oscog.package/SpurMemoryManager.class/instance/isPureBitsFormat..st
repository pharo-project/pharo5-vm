header formats
isPureBitsFormat: format
	"the inverse of isAnyPointerFormat:"
	^format >= self sixtyFourBitIndexableFormat
	  and: [format < self firstCompiledMethodFormat]