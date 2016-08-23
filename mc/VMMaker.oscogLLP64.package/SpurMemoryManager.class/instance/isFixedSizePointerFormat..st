header format
isFixedSizePointerFormat: format
	<api>
	^format <= self nonIndexablePointerFormat
	  or: [format = self ephemeronFormat]