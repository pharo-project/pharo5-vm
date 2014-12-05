message sending
executeNewMethodWithPrimitive220
	<doNotGenerate>
	"ESTEBAN: This is not working fine, so I'm suppresing them. 
	 So far, is also not used in NB so is not an immediate problem."
	
	"Execute newMethod - either primitiveFunctionPointer must be set directly
	 (i.e. from primitiveExecuteMethod et al), or it would have been set probing
	 the method cache (i.e. primitivePerform et al).
	 Eagerly compile it if appropriate so that doits are fast."
	| methodHeader inInterpreter |
	inInterpreter := instructionPointer >= objectMemory startOfMemory.
	
	"This tests that the newMethod is a compiled method and not a normal object acting as a method. The latter, since it is not a method, will have not header nor jitted code and cannot therefore be activated"
	
	(self isCompiledMethod: newMethod) ifTrue: [
		"Eagerly compile it if appropriate so that doits are fast."
		methodHeader := self rawHeaderOf: newMethod. 
		(self isCogMethodReference: methodHeader) ifTrue: [
			self executeCoggedNewMethod: inInterpreter methodHeader: methodHeader.
			^nil ] ].

	"Here are handled both primitives and object as methods handling.
	The primitiveFunctionPointer is a pointer to either the function implementing the primitive of the method or the function implementing the runWithIn for objects as methods"
	primitiveFunctionPointer ~= 0 ifTrue:
		[self isPrimitiveFunctionPointerAnIndex ifTrue:
			[self externalQuickPrimitiveResponse.
			 self return: self popStack toExecutive: inInterpreter.
			 ^nil].
		 "slowPrimitiveResponse may of course context-switch.  If so we must reenter the
		  new process appopriately, returning only if we've reached here directly from the
		  interpreter and have found an interpreter frame.  The instructionPointer tells us
		  from whence we came."
		 self slowPrimitiveResponse ifTrue:
			[self return: self popStack toExecutive: inInterpreter.
			 ^nil]].
	
	(self isCogMethodReference: methodHeader) ifFalse:
		[(self methodWithHeaderShouldBeCogged: methodHeader)
			ifTrue:
				[cogit cog: newMethod selector: objectMemory nilObject.
				 methodHeader := self rawHeaderOf: newMethod]
			ifFalse: [self maybeFlagMethodAsInterpreted: newMethod]].
	"if not primitive, or primitive failed, activate the method"
	(self isCogMethodReference: methodHeader)
		ifTrue:
			[instructionPointer asUnsignedInteger >= objectMemory startOfMemory ifTrue:
				[self iframeSavedIP: framePointer put: instructionPointer asInteger.
				 instructionPointer := cogit ceReturnToInterpreterPC].
			self activateCoggedNewMethod: inInterpreter]
		ifFalse:
			[self activateNewMethod]