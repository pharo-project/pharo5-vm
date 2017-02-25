compile abstract instructions
compileAbstractInstructionsFrom: start through: end
	"Loop over bytecodes, dispatching to the generator for each bytecode, handling fixups in due course.
	 Override to provide a development-time only escape for failed merges due to partially implemented
	 parallel move."
	^[super compileAbstractInstructionsFrom: start through: end]
		on: Notification
		do: [:ex|
			ex tag == #failedMerge ifTrue:
				[coInterpreter transcript
					ensureCr; nextPutAll: 'FAILED MERGE IN ';
					nextPutAll: (coInterpreter nameOfClass: (coInterpreter methodClassOf: methodObj));
					nextPutAll: '>>#'; nextPutAll: (coInterpreter stringOf: (coInterpreter maybeSelectorOfMethod: methodObj));
					flush.
				 ^ShouldNotJIT].
			ex pass]