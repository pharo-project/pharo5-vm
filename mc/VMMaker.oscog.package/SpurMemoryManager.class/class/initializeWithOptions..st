class initialization
initializeWithOptions: optionsDictionary
	"SpurMemoryManager initializeWithOptions: Dictionary new"

	super initializeWithOptions: optionsDictionary.
	self initialize.
	self initBytesPerWord: (self == SpurMemoryManager
								ifTrue: [optionsDictionary at: #BytesPerWord ifAbsent: [4]]
								ifFalse: [self wordSize]).
	BytesPerOop := optionsDictionary at: #BytesPerOop ifAbsent: [BytesPerWord].

	self initializeObjectHeaderConstants. "Initializes BaseHeaderSize so do early"
	self initializeSpurObjectRepresentationConstants.
	self initializeSpecialObjectIndices.
	self initializeCompactClassIndices.
	self initializePrimitiveErrorCodes.

	SpurGenerationScavenger initialize