class initialization
initializeWithOptions: optionsDictionary
	"SpurMemoryManager initializeWithOptions: Dictionary new"

	{self}, (self ancilliaryClasses: optionsDictionary) do:
		[:aSuperclass|
		 aSuperclass withAllSubclasses do:
			[:class| class initializationOptions: optionsDictionary]].

	super initializeWithOptions: optionsDictionary.
	initializationOptions
		at: #Spur32BitMemoryManager ifAbsentPut: false;
		at: #Spur64BitMemoryManager ifAbsentPut: false.
	self initialize.
	self initBytesPerWord: (self == SpurMemoryManager
								ifTrue: [optionsDictionary at: #BytesPerWord ifAbsent: [4]]
								ifFalse: [self wordSize]).

	self initializeObjectHeaderConstants. "Initializes BaseHeaderSize so do early"
	self initializeSpurObjectRepresentationConstants.
	self initializeSpecialObjectIndices.
	self initializeCompactClassIndices.
	self initializePrimitiveErrorCodes.

	SpurGenerationScavenger initialize