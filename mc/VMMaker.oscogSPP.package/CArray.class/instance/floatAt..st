accessing
floatAt: index
	^ Float fromIEEE32Bit: (self at: index)