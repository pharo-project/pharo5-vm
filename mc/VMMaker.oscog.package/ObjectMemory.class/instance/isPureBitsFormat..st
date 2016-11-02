header formats
isPureBitsFormat: format
	^format >= self firstLongFormat
	  and: [format < self firstCompiledMethodFormat]