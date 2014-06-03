header format
isFixedSizePointerFormat: format
	^format <= self nonIndexablePointerFormat
	  or: [format = self ephemeronFormat]