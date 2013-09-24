header access
isIndexableFormat: format
	^format >= self arrayFormat
	  and: [format <= self weakArrayFormat
			or: [format >= self firstLongFormat]]