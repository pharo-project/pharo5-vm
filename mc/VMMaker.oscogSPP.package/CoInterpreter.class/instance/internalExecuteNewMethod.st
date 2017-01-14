message sending
internalExecuteNewMethod
	<inline: true>
	"For interpreter performance and to ease the objectAsMethod implementation eagerly
	 evaluate the primtiive, i.e. if the method is cogged and has a primitive /do not/ evaluate
	 the machine code primitive, just evaluate primitiveFunctionPointer directly."
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