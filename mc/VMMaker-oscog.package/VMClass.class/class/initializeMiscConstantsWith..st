initialization
initializeMiscConstantsWith: optionsDictionary
	"Falsify the `what type of VM is this?' flags that are defined in the various interp.h files,
	 or in the case of VMBIGENDIAN the various sqConfig.h files.
	 Subclass implementations need to include a super initializeMiscConstantsWith:."

	VMBIGENDIAN class. "Mention this for the benefit of CCodeGenerator>>emitCConstantsOn:"
	self isInterpreterClass ifTrue:
		[STACKVM := COGVM := COGMTVM := false].
	NewspeakVM := optionsDictionary at: #NewspeakVM ifAbsent: [false].
	MULTIPLEBYTECODESETS := optionsDictionary at: #MULTIPLEBYTECODESETS ifAbsent: [false].
	"N.B.  Not yet implemented."
	IMMUTABILITY := optionsDictionary at: #IMMUTABILITY ifAbsent: [false].

	"These for scripts etc... Usually they should get set by an Interpreter class's initializeMiscConstantsWith:"
	(optionsDictionary includesKey: #STACKVM) ifTrue:
		[STACKVM := optionsDictionary at: #STACKVM].
	(optionsDictionary includesKey: #COGVM) ifTrue:
		[COGVM := optionsDictionary at: #COGVM].
	(optionsDictionary includesKey: #COGMTVM) ifTrue:
		[COGMTVM := optionsDictionary at: #COGMTVM]