enilopmarts
ceActivateFailingPrimitiveMethod: aPrimitiveMethod
	"An external call or FFI primitive has failed.  Build the frame and
	 activate as appropriate.  Enter either the interpreter or machine
	 code depending on whether aPrimitiveMethod has been or is still
	 cogged.  Note that we could always interpret but want the efficiency
	 of executing machine code if it is available."
	<api>
	| methodHeader |
	self assert: primFailCode ~= 0.
	self assert: newMethod = aPrimitiveMethod.
	"If we're on Spur, check for forwarders and retry,
	 returning if successful the second time around."
	(objectMemory hasSpurMemoryManagerAPI
	 and: [(objectMemory isOopCompiledMethod: newMethod)
	 and: [self checkForAndFollowForwardedPrimitiveState]]) ifTrue:
		[self initPrimCall.
		 self cCode: [self dispatchFunctionPointer: primitiveFunctionPointer]
			inSmalltalk:
				[| evaluable |
				 evaluable := primitiveFunctionPointer isInteger
								ifTrue: [cogit simulatedTrampolines at: primitiveFunctionPointer]
								ifFalse: [primitiveFunctionPointer].
				 evaluable isMessageSend
					ifTrue: [self assert: evaluable receiver == self]
					ifFalse: [self assert: evaluable isBlock].
				 evaluable value].
		 self successful ifTrue:
			[^self]].
	methodHeader := self rawHeaderOf: aPrimitiveMethod.
	(self isCogMethodReference: methodHeader)
		ifTrue: [self activateCoggedNewMethod: false]
		ifFalse: [self activateNewMethod]