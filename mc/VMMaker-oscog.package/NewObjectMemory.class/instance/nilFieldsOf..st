primitive support
nilFieldsOf: arrayObj 
	0 to: (self lengthOf: arrayObj) - 1 do:
		[:i|
		self storePointerUnchecked: i ofObject: arrayObj withValue: nilObj]