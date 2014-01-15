class initialization
initializeWithOptions: optionsDictionary

	self initializeMiscConstantsWith: optionsDictionary. "must preceed other initialization."
	self initializeErrorCodes.
	self initializeCogMethodConstants.
	self initializeAnnotationConstants.
	self initializeBytecodeTable.
	self initializePrimitiveTable