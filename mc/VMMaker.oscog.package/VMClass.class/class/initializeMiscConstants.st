initialization
initializeMiscConstants
	"Falsify the `what type of VM is this?' flags that are defined in the various interp.h files,
	 or in the case of VMBIGENDIAN the various sqConfig.h files.
	 Subclass implementations need to include a super initializeMiscConstants"

	| omc |
	VMBIGENDIAN class. "Mention this for the benefit of CCodeGenerator>>emitCConstantsOn:"
	self isInterpreterClass ifTrue:
		[STACKVM := COGVM := COGMTVM := false].

	initializationOptions ifNil: [self initializationOptions: Dictionary new].
	omc := initializationOptions at: #ObjectMemory ifAbsent: nil.
	initializationOptions
		at: #SqueakV3ObjectMemory	"the good ole default"
			put: (omc
					ifNil: [true]
					ifNotNil: [(Smalltalk at: omc) inheritsFrom: ObjectMemory]);
		at: #SpurObjectMemory		"the new condender"
			put: (omc
					ifNil: [false]
					ifNotNil: [(Smalltalk at: omc) inheritsFrom: SpurMemoryManager]).

	"Use ifAbsentPut: so that they will get copied back to the
	 VMMaker's options and dead code will likely be eliminated."
	NewspeakVM := initializationOptions at: #NewspeakVM ifAbsentPut: [false].
	MULTIPLEBYTECODESETS := initializationOptions at: #MULTIPLEBYTECODESETS ifAbsentPut: [false].
	"N.B.  Not yet implemented."
	IMMUTABILITY := initializationOptions at: #IMMUTABILITY ifAbsentPut: [false].

	"These for scripts etc... Usually they should get set by an Interpreter class's initializeMiscConstantsWith:"
	(initializationOptions includesKey: #STACKVM) ifTrue:
		[STACKVM := initializationOptions at: #STACKVM].
	(initializationOptions includesKey: #COGVM) ifTrue:
		[COGVM := initializationOptions at: #COGVM].
	(initializationOptions includesKey: #COGMTVM) ifTrue:
		[COGMTVM := initializationOptions at: #COGMTVM]