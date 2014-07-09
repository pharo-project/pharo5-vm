process primitives
primitiveProfileSemaphore
	"Primitive. Install the semaphore to be used for profiling, 
	or nil if no semaphore should be used.
	See also primitiveProfileStart."
	| sema flushState activeContext |
	<export: true>
	self methodArgumentCount ~= 1 ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	sema := self stackValue: 0.
	sema = objectMemory nilObject
		ifTrue:
			[flushState := profileSemaphore ~= objectMemory nilObject]
		ifFalse:
			[flushState := profileSemaphore = objectMemory nilObject.
			 (objectMemory isSemaphoreOop: sema) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument]].
	profileSemaphore := sema.
	"If we've switched profiling on or off we must void machine code
	 (and machine code pcs in contexts) since we will start or stop
	 testing the profile clock in machine code primitive invocations,
	 and so generate slightly different code from here on in."
	flushState ifTrue:
		[self push: instructionPointer.
		 activeContext := self voidVMStateForSnapshotFlushingExternalPrimitivesIf: false.
		 self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext.
		 self assert: (((self stackValue: 0) = objectMemory nilObject and: [profileSemaphore = objectMemory nilObject])
				  or: [(self stackValue: 0) = profileSemaphore
					  and: [objectMemory isSemaphoreOop: sema]])].
	profileProcess := profileMethod := objectMemory nilObject.
	self pop: 1.
	flushState ifTrue:
		[self siglong: reenterInterpreter jmp: ReturnToInterpreter]