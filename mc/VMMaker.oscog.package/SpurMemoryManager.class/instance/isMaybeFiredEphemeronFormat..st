header formats
isMaybeFiredEphemeronFormat: format
	"Answer if an object's format could be that of an ephemeron.  When ephemerons are born
	 their format is ephemeronFormat, but when they fire their format is changed to 3 (inst vars
	 plus indexable fields) or 1 (objects with inst vars), we haven't decided which yet."
	^format <= self lastPointerFormat and: [format odd]