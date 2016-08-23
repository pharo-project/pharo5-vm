control primitives
primitivePerformAt: lookupClass
	"Common routine used by perform:withArgs: and perform:withArgs:inSuperclass:"

	"NOTE:  The case of doesNotUnderstand: is not a failure to perform.
	The only failures are arg types and consistency of argumentCount."

	| performSelector argumentArray arraySize index cntxSize performMethod performArgCount |
	argumentArray := self stackTop.
	(self isArray: argumentArray) ifFalse:[^self primitiveFail].

	successFlag ifTrue:
		["Check for enough space in thisContext to push all args"
		arraySize := self numSlotsOf: argumentArray.
		cntxSize := self numSlotsOf: activeContext.
		self success: (self stackPointerIndex + arraySize) < cntxSize].
	successFlag ifFalse: [^nil].

	performSelector := messageSelector.
	performMethod := newMethod.
	performArgCount := argumentCount.
	"pop the arg array and the selector, then push the args out of the array, as if they were on the stack"
	self popStack.
	messageSelector := self popStack.

	"Copy the arguments to the stack, and execute"
	index := 1.
	[index <= arraySize]
		whileTrue:
		[self push: (self fetchPointer: index - 1 ofObject: argumentArray).
		index := index + 1].
	argumentCount := arraySize.

	self findNewMethodInClass: lookupClass.

	"Only test CompiledMethods for argument count - any other objects playacting as CMs will have to take their chances"
	(self isOopCompiledMethod: newMethod)
		ifTrue: [self success: (self argumentCountOf: newMethod) = argumentCount].

	successFlag
		ifTrue: [self executeNewMethod.  "Recursive xeq affects successFlag"
				successFlag := true]
		ifFalse: ["Restore the state by popping all those array entries and pushing back the selector and array, and fail"
				self pop: argumentCount.
				self push: messageSelector.
				self push: argumentArray.
				messageSelector := performSelector.
				newMethod := performMethod.
				argumentCount := performArgCount]
