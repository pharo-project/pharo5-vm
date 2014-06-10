initialization
initializeWithOptions: optionsDictionary
	"NewspeakInterpreter initializeWithOptions: Dictionary new"

	super initializeWithOptions: optionsDictionary.  "initialize ObjectMemory constants"
	self initializeMiscConstants. "must preceed other initialization."
	self initializeAssociationIndex.
	self initializeBytecodeTable.
	self initializeCaches.
	self initializeCharacterIndex.
	self initializeCharacterScannerIndices.
	self initializeClassIndices.
	self initializeContextIndices.
	self initializeDirectoryLookupResultCodes.
	self initializeMessageIndices.
	self initializeMethodIndices.
	self initializePointIndices.
	self initializePrimitiveTable.
	self initializePrimitiveErrorCodes.
	self initializeSchedulerIndices.
	self initializeSmallIntegers.
	self initializeStreamIndices