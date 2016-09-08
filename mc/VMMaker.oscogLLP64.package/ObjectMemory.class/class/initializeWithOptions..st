initialization
initializeWithOptions: optionsDictionary
	"ObjectMemory initializeWithOptions: Dictionary new"

	self initBytesPerWord: (optionsDictionary at: #BytesPerWord ifAbsent: [4]).
	BytesPerOop := optionsDictionary at: #BytesPerOop ifAbsent: [BytesPerWord].

	"Translation flags (booleans that control code generation via conditional translation):"
	"generate assertion checks"
	DoAssertionChecks := optionsDictionary at: #DoAssertionChecks ifAbsent: [false].
	DoExpensiveAssertionChecks := optionsDictionary at: #DoExpensiveAssertionChecks ifAbsent: [false].

	self initializeObjectHeaderConstants. "Initializes BaseHeaderSize so do early"
	self initializeSpecialObjectIndices.
	self initializeCompactClassIndices.
	self initializePrimitiveErrorCodes.

	NilContext := 1.  "the oop for the integer 0; used to mark the end of context lists"

	RemapBufferSize := 25.
	RootTableSize := 2500.  	"number of root table entries (4 bytes/entry)"
	RootTableRedZone := RootTableSize - 100.	"red zone of root table - when reached we force IGC"
	WeakRootTableSize := RootTableSize + RemapBufferSize + 100.

	"tracer actions"
	StartField := 1.
	StartObj := 2.
	Upward := 3.
	Done := 4.

	ExtraRootSize := 2048. "max. # of external roots"