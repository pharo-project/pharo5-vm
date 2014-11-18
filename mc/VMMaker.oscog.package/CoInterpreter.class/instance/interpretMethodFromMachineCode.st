message sending
interpretMethodFromMachineCode
	"Execute a method interpretively from machine code.  We assume (require) that newMethod
	 messageSelector, primitiveFunctionPointer and argumentCount have been set in the caller.
	 Once evaluated either continue in the interpreter via a jongjmp or in machine code via an
	 enilopmart (a form of longjmp - a stinking rose by any other name)."
	<inline: false>
	cogit assertCStackWellAligned.
	self assert: (self validInstructionPointer: instructionPointer inFrame: framePointer).
	primitiveFunctionPointer ~= 0
		ifTrue:
			[primitiveFunctionPointer = #primitiveInvokeObjectAsMethod
				ifTrue: [self assert: (objectMemory isOopCompiledMethod: newMethod) not]
				ifFalse: [self assert: ((objectMemory isOopCompiledMethod: newMethod)
									  and: [(self primitiveIndexOf: newMethod) ~= 0])].
			 "Invoke an interpreter primitive (because the method is to be interpreted or has not yet been
			  compiled).  This is very similar to invoking an interpreter primitive from a compiled primitive
			  (see e.g. SimpleStackBasedCogit>>compileInterpreterPrimitive:).  Cut back the stack pointer
			  (done above) to skip the return address and invoke the function.  On return if it has succeeded
			  simply continue otherwise restore the stackPointer, collect the pc and interpret.  Note that
			  frame building primitives such as primitiveClosureValue, primitiveEvaluateMethod et al will not
			  return but will instead jump into either machine code or longjmp back to the interpreter."
			"Assign stackPage headFP so we can tell if the primitive built a frame.  We can't simply save
			 the framePointer since e.g. assignment to contexts (via primitiveInstVarAt:put:) can change the
			 framePointer.  But context assignments will change both the framePointer and stackPage headFP."
			
			 self assert: (framePointer < stackPage baseAddress
						and: [framePointer > (stackPage realStackLimit - (LargeContextSlots * objectMemory bytesPerOop / 2))]).
			 stackPage headFP: framePointer.
			 self isPrimitiveFunctionPointerAnIndex
				ifTrue:
					[self externalQuickPrimitiveResponse.
					 primFailCode := 0]
				ifFalse:
					[self slowPrimitiveResponse].
			self successful ifTrue:
				[self return: self popStack toExecutive: false
				 "NOTREACHED"]]
		ifFalse:
			[self assert: ((objectMemory isOopCompiledMethod: newMethod)
						   and: [(self primitiveIndexOf: newMethod) = 0
								or: [(self functionPointerFor: (self primitiveIndexOf: newMethod) inClass: objectMemory nilObject) = 0
								or: [self isNullExternalPrimitiveCall: newMethod]]])].
	"if not primitive, or primitive failed, activate the method and reenter the interpreter"
	self activateNewMethod.
	self siglong: reenterInterpreter jmp: ReturnToInterpreter.
	"NOTREACHED"
	^nil