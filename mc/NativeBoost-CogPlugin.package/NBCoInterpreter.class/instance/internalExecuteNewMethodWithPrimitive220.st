message sending
internalExecuteNewMethodWithPrimitive220
	<doNotGenerate>
	"ESTEBAN: This is not working fine, so I'm suppresing them. 
	 So far, is also not used in NB so is not an immediate problem."

	<inline: true>
	"For interpreter performance and to ease the objectAsMethod implementation eagerly
	 evaluate the primtiive, i.e. if the method is cogged and has a primitive /do not/ evaluate
	 the machine code primitive, just evaluate primitiveFunctionPointer directly."
	 | methodHeader |
	
	"This tests that the newMethod is a compiled method and not a normal object acting as a method. The latter, since it is not a method, will have not header nor jitted code and cannot therefore be activated"
	(self isCompiledMethod: newMethod) ifTrue: [
		"Eagerly compile it if appropriate so that doits are fast."
		"If the method is a compiled method that is cogged we try to run it. The method may be a normal object that is used as a method. It should be handled in the common way"
		methodHeader := self rawHeaderOf: newMethod.
		(self isCogMethodReference: methodHeader) ifTrue: [
			self externalizeIPandSP.
			self executeCoggedNewMethod: true methodHeader: methodHeader.
			"we never reach here"
			].
	].

	"Here are handled both primitives and object as methods handling.
	The primitiveFunctionPointer is a pointer to either the function implementing the primitive of the method or the function implementing the runWithIn for objects as methods"
	primitiveFunctionPointer ~= 0 ifTrue:
		[| succeeded |
		 self isPrimitiveFunctionPointerAnIndex ifTrue:
			[^self internalQuickPrimitiveResponse].
		 "slowPrimitiveResponse may of course context-switch.  If so we must reenter the
		  new process appropriately, returning only if we've found an interpreter frame."
		 self externalizeIPandSP.
		 succeeded := self slowPrimitiveResponse.
		 instructionPointer = cogit ceReturnToInterpreterPC ifTrue:
			[instructionPointer := self iframeSavedIP: framePointer].
		 self internalizeIPandSP.
		 succeeded ifTrue:
			[self return: self popStack toExecutive: true.
			 self browserPluginReturnIfNeeded.
			^nil]].
	"if not primitive, or primitive failed, activate the method"
	(self methodHasCogMethod: newMethod)
		ifTrue: [self iframeSavedIP: localFP put: localIP asInteger.
				instructionPointer := cogit ceReturnToInterpreterPC.
				self externalizeFPandSP.
				self activateCoggedNewMethod: true.
				self internalizeIPandSP]
		ifFalse: [self internalActivateNewMethod]