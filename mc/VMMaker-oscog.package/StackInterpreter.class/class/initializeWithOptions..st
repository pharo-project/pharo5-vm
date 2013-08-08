initialization
initializeWithOptions: optionsDictionary
	"StackInterpreter initializeWithOptions: Dictionary new"

	NewObjectMemory initializeWithOptions: optionsDictionary.  "initialize ObjectMemory constants"
	self initializeMiscConstantsWith: optionsDictionary. "must preceed other initialization."
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