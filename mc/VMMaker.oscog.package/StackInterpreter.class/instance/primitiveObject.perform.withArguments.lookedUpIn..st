control primitives
primitiveObject: actualReceiver perform: selector withArguments: argumentArray lookedUpIn: lookupClassOrNil
	"Common routine used by perform:withArgs:, perform:withArgs:inSuperclass:,
	 object:perform:withArgs:inClass: et al.  Answer nil on success.

	 NOTE:  The case of doesNotUnderstand: is not a failure to perform.
	 The only failures are arg types and consistency of argumentCount.

	 Since we're in the stack VM we can assume there is space to push the arguments
	 provided they are within limits (max argument count is 15).  We can therefore deal
	 with the arbitrary amount of state to remove from the stack (lookup class, selector,
	 mirror receiver) and arbitrary argument orders by deferring popping anything until
	 we know whether the send has succeeded.  So on failure we merely have to remove
	 the actual receiver and arguments pushed, and on success we have to slide the actual
	 receiver and arguments down to replace the original ones."
	<inline: true>
	| arraySize performArgCount delta |
	(objectMemory isArray: argumentArray) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].

	"Check if number of arguments is reasonable; MaxNumArgs isn't available
	 so just use LargeContextSize"
	arraySize := objectMemory numSlotsOf: argumentArray.
	arraySize > (LargeContextSlots - CtxtTempFrameStart) ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].

	performArgCount := argumentCount.
	"Push newMethod to save it in case of failure,
	 then push the actual receiver and the args in the array."
	self push: newMethod.
	self push: actualReceiver.
	"Copy the arguments to the stack, in case of MNU, and lookup"
	1 to: arraySize do:
		[:index| self push: (objectMemory fetchPointer: index - 1 ofObject: argumentArray)].
	argumentCount := arraySize.
	messageSelector := selector.
	self sendBreakpoint: messageSelector receiver: actualReceiver.
	self printSends ifTrue:
		[self printActivationNameForSelector: messageSelector
				startClass: (lookupClassOrNil isNil
								ifTrue: [objectMemory fetchClassOf: actualReceiver]
								ifFalse: [lookupClassOrNil]);
			cr].
	self findNewMethodInClassTag: (lookupClassOrNil isNil
										ifTrue: [objectMemory fetchClassTagOf: actualReceiver]
										ifFalse: [objectMemory classTagForClass: lookupClassOrNil]).

	"Only test CompiledMethods for argument count - any other objects playacting as CMs will have to take their chances"
	((objectMemory isOopCompiledMethod: newMethod)
	  and: [(self argumentCountOf: newMethod) ~= argumentCount]) ifTrue:
		["Restore the state by popping the array entries, the actual receiver and the saved
		  newMethod, leaving the selector and array, and fail.  N.B.  If an MNU has happened
		  then argumentCount will match newMethod, so this code will not be reached."
		 "These asserts check that an MNU has not occurred if the argumentCount doesn't match the newMethod."
		 self assert: (self stackTop = (arraySize = 0
											ifTrue: [actualReceiver]
											ifFalse: [(objectMemory fetchPointer: arraySize - 1 ofObject: argumentArray)])).
		 self assert:  argumentCount = arraySize.
		 self pop: arraySize + 1.
		 newMethod := self popStack.
		 ^self primitiveFailFor: PrimErrBadNumArgs].

	"Cannot fail this primitive from here-on.  Slide the actual receiver and arguments down
	 to replace the perform arguments and saved newMethod and then execute the new
	 method. Use argumentCount not arraySize because an MNU may have changed it."
	delta := objectMemory wordSize * (performArgCount + 2). "+2 = receiver + saved newMethod"
	argumentCount * objectMemory wordSize to: 0 by: objectMemory wordSize negated do:
		[:offset|
		stackPages
			longAt: stackPointer + offset + delta
			put: (stackPages longAt: stackPointer + offset)].
	self pop: performArgCount + 2.
	self executeNewMethod.
	self initPrimCall.  "Recursive xeq affects primErrorCode"
	^nil