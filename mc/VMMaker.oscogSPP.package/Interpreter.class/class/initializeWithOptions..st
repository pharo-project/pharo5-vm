initialization
initializeWithOptions: optionsDictionary
	"Interpreter initializeWithOptions: Dictionary new"

	super initializeWithOptions: optionsDictionary.  "initialize ObjectMemory constants"
	self initializeMiscConstants. "must precede other initialization."
	self initializeAssociationIndex.
	self initializeBytecodeTable.
	self initializeCaches.
	self initializeCharacterIndex.
	self initializeCharacterScannerIndices.
	self initializeClassIndices.
	self initializeCompilerHooks.
	self initializeContextIndices.
	self initializeDirectoryLookupResultCodes.
	self initializeMessageIndices.
	self initializeMethodIndices.
	self initializePointIndices.
	self initializePrimitiveTable.
	self initializeSchedulerIndices.
	self initializeSmallIntegers.
	self initializeStreamIndices