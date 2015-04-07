class initialization
initializeWithOptions: optionsDictionary
	{ self. CogMethod. CogMethodSurrogate. CogObjectRepresentation } do:
		[:aSuperclass|
		 aSuperclass withAllSubclasses do:
			[:class| class initializationOptions: optionsDictionary]].
	super initializeWithOptions: optionsDictionary.
	self initializeBytecodeTable.
	self initializeMiscConstants. "must preceed other initialization."
	self initializeErrorCodes.
	self initializeCogMethodConstants.
	self initializeAnnotationConstants.
	self initializePrimitiveTable