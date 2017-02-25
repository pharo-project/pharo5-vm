initialization
initializeWithOptions: optionsDictionary
	super initializeWithOptions: optionsDictionary.

	ByteCountsPerMicrosecond := initializationOptions
										at: #ByteCountsPerMicrosecond
										ifAbsent: [100]