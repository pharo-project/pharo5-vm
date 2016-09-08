header formats
isIndexableFormat: format
	^format >= self arrayFormat
	  and: [format <= self weakArrayFormat
			or: [format >= self sixtyFourBitIndexableFormat]]