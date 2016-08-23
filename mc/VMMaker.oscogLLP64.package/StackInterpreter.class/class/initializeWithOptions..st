initialization
initializeWithOptions: optionsDictionary
	"StackInterpreter initializeWithOptions: Dictionary new"

	super initializeWithOptions: optionsDictionary.
	(self primitivesClass withAllSuperclasses copyUpTo: StackInterpreter) do:
		[:class| class initializationOptions: initializationOptions].
	self initializeMiscConstants. "must precede other initialization."
	self initializeAssociationIndex.
	self initializeBytecodeTable.
	self initializeCaches.
	self initializeCharacterIndex.
	self initializeCharacterScannerIndices.
	self initializeClassIndices.
	self initializeContextIndices.
	self initializeDirectoryLookupResultCodes.
	self initializeFrameIndices.
	self initializeMessageIndices.
	self initializeMethodIndices.
	self initializePointIndices.
	self initializePrimitiveTable.
	self initializeSchedulerIndices.
	self initializeSmallIntegers.
	self initializeStreamIndices