memory access
at: index put: value

	super at: index put: (self bitsOf: value).
	^ simArray at: index + 1 put: value.
	