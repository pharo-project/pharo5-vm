class initialization
initializeWithOptions: optionsDictionary
	{ self. CogMethod. CogMethodSurrogate. CogObjectRepresentation } do:
		[:aSuperclass|
		 aSuperclass withAllSubclasses do:
			[:class| class initializationOptions: optionsDictionary]].
	super initializeWithOptions: optionsDictionary.
	self initializeMiscConstants. "must precede other initialization."
	self initializeErrorCodes.
	self initializeCogMethodConstants.
	self initializeAnnotationConstants.
	self initializeBytecodeTable.
	self initializeNumTrampolines.
	self initializePrimitiveTable