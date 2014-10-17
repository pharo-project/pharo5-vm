process primitives
primitiveLongRunningPrimitiveSemaphore
	"Primitive. Install the semaphore to be used for collecting long-running primitives, 
	 or nil if no semaphore should be used."
	| sema flushState activeContext |
	<export: true>
	self methodArgumentCount ~= 1 ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	sema := self stackValue: 0.
	sema = objectMemory nilObject
		ifTrue:
			[flushState := longRunningPrimitiveCheckSemaphore notNil.
			 longRunningPrimitiveCheckSemaphore := nil]
		ifFalse:
			[flushState := longRunningPrimitiveCheckSemaphore isNil.
			 (objectMemory isSemaphoreOop: sema) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument].
			 longRunningPrimitiveCheckSemaphore := sema].
	"If we've switched checking on or off we must void machine code
	 (and machine code pcs in contexts) since we will start or stop setting
	 newMethod in machine code primitive invocations, and so generate
	 slightly different code from here on in."
	flushState ifTrue:
		[self push: instructionPointer.
		 activeContext := self voidVMStateForSnapshotFlushingExternalPrimitivesIf: false.
		 self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext.
		 self assert: (((self stackValue: 0) = objectMemory nilObject and: [longRunningPrimitiveCheckSemaphore isNil])
				  or: [(self stackValue: 0) = longRunningPrimitiveCheckSemaphore
					  and: [objectMemory isSemaphoreOop: sema]])].
	self voidLongRunningPrimitive: 'install'.
	self pop: 1.
	flushState ifTrue:
		[self siglong: reenterInterpreter jmp: ReturnToInterpreter]