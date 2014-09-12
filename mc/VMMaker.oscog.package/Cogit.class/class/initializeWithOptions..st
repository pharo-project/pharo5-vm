class initialization
initializeWithOptions: optionsDictionary
	{ self. CogMethod. CogMethodSurrogate. CogObjectRepresentation } do:
		[:superclass|
		 superclass withAllSubclasses do:
			[:class| class initializationOptions: optionsDictionary]].
	super initializeWithOptions: optionsDictionary.
	self initializeMiscConstants. "must preceed other initialization."
	self initializeErrorCodes.
	self initializeCogMethodConstants.
	self initializeAnnotationConstants.
	self initializeBytecodeTable.
	self initializePrimitiveTable