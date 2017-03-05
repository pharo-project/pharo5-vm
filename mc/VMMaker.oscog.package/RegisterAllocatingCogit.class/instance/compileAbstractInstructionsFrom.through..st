compile abstract instructions
compileAbstractInstructionsFrom: start through: end
	"Loop over bytecodes, dispatching to the generator for each bytecode, handling fixups in due course.
	 Override to provide a development-time only escape for failed merges due to partially implemented
	 parallel move.  Override to recompile after a loop requiring a merge is detected."
	^[| result initialOpcodeIndex initialCounterIndex initialIndexOfIRC |
	   compilationPass := 1.
	   initialOpcodeIndex := opcodeIndex.
	   initialCounterIndex := self maybeCounterIndex."for SistaCogit"
	   literalsManager saveForRecompile.
	   NewspeakVM ifTrue:
			[initialIndexOfIRC := indexOfIRC].
	   [recompileForLoopRegisterAssignments := false.
	    result := super compileAbstractInstructionsFrom: start through: end.
	    result = 0 and: [recompileForLoopRegisterAssignments]]
		whileTrue:
			[self reinitializeAllButBackwardFixupsFrom: start through: end.
			 self resetSimStack: start.
			 self reinitializeOpcodesFrom: initialOpcodeIndex to: opcodeIndex - 1.
			 compilationPass := compilationPass + 1.
			 nextFixup := 0.
			 opcodeIndex := initialOpcodeIndex.
			 self maybeSetCounterIndex: initialCounterIndex. "For SistaCogit"
			 literalsManager resetForRecompile.
			 NewspeakVM ifTrue:
				[indexOfIRC := initialIndexOfIRC]].
	    result]
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