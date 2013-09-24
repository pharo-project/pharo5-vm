class initialization
initializeWithOptions: optionsDictionary
	"SpurMemoryManager initializeWithOptions: Dictionary new"

	self initBytesPerWord: (self == SpurMemoryManager
								ifTrue: [optionsDictionary at: #BytesPerWord ifAbsent: [4]]
								ifFalse: [self wordSize]).
	BytesPerOop := optionsDictionary at: #BytesPerOop ifAbsent: [BytesPerWord].

	self initializeSpurObjectRepresentationConstants.
	self initializeSpecialObjectIndices.
	self initializeCompactClassIndices.
	self initializePrimitiveErrorCodes.
	self initializeObjectHeaderConstants.

	SpurGenerationScavenger initialize