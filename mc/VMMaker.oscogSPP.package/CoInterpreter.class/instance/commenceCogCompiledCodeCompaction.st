cog jit support
commenceCogCompiledCodeCompaction
	| startTime |
	<var: #startTime type: #usqLong>
	cogCompiledCodeCompactionCalledFor := false.
	cogit recordEventTrace ifTrue:
		[self recordTrace: TraceCodeCompaction thing: TraceCodeCompaction source: 0].
	cogit recordPrimTrace ifTrue:
		[self fastLogPrim: TraceCodeCompaction].
	startTime := self ioUTCMicrosecondsNow.

	"This can be called in a number of circumstances.  The instructionPointer
	 may contain a native pc that must be relocated.  There may already be a
	 pushed instructionPointer on stack.  Clients ensure that instructionPointer
	 is 0 if it should not be pushed and/or relocated.  Pushing twice is a mistake
	 because only the top one will be relocated."
	instructionPointer ~= 0 ifTrue:
		["better not have already been pushed"
		 self assert: self stackTop asUnsignedInteger ~= instructionPointer.
		 self push: instructionPointer.
		 self externalWriteBackHeadStackPointer].
	self assertValidStackedInstructionPointers: #'__LINE__'.
	cogit compactCogCompiledCode.
	self nilUncoggableMethods.
	instructionPointer ~= 0 ifTrue:
		[instructionPointer := self popStack.
		 self externalWriteBackHeadStackPointer].
	self assertValidStackedInstructionPointers: #'__LINE__'.

	statCodeCompactionCount := statCodeCompactionCount + 1.
	statCodeCompactionUsecs := statCodeCompactionUsecs + (self ioUTCMicrosecondsNow - startTime).

	objectMemory checkForLeaks ~= 0 ifTrue:
		[objectMemory clearLeakMapAndMapAccessibleObjects.
		 self asserta: (self checkCodeIntegrity: false)]