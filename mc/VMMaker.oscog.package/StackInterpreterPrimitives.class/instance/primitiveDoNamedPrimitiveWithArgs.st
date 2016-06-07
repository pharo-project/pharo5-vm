plugin primitives
primitiveDoNamedPrimitiveWithArgs
	"Simulate an primitiveExternalCall invocation (e.g. for the Debugger).  Do not cache anything.
	 e.g. ContextPart>>tryNamedPrimitiveIn: aCompiledMethod for: aReceiver withArgs: arguments"
	| argumentArray arraySize methodArg methodHeader
	  moduleName functionName moduleLength functionLength
	  spec addr primRcvr isArray |
	<var: #addr declareC: 'void (*addr)()'>
	argumentArray := self stackTop.
	methodArg := self stackValue: 2.
	((objectMemory isArray: argumentArray)
	 and: [objectMemory isOopCompiledMethod: methodArg]) ifFalse:
		[^self primitiveFailFor: -2]. "invalid args"
	arraySize := objectMemory numSlotsOf: argumentArray.
	(self roomToPushNArgs: arraySize) ifFalse:
		[^self primitiveFailFor: -2]. "invalid args"

	methodHeader := objectMemory methodHeaderOf: methodArg.
	(objectMemory literalCountOfMethodHeader: methodHeader) > 2 ifFalse:
		[^self primitiveFailFor: -3]. "invalid methodArg state"
	spec := objectMemory fetchPointer: 1 "first literal" ofObject: methodArg.
	isArray := self isInstanceOfClassArray: spec.
	(isArray
	and: [(objectMemory numSlotsOf: spec) = 4
	and: [(self primitiveIndexOfMethod: methodArg header: methodHeader) = PrimNumberExternalCall]]) ifFalse:
		[^self primitiveFailFor: -3]. "invalid methodArg state"

	(self argumentCountOfMethodHeader: methodHeader) = arraySize ifFalse:
		[^self primitiveFailFor: -2]. "invalid args (Array args wrong size)"

	"The function has not been loaded yet. Fetch module and function name."
	moduleName := objectMemory fetchPointer: 0 ofObject: spec.
	moduleName = objectMemory nilObject
		ifTrue: [moduleLength := 0]
		ifFalse: [self success: (objectMemory isBytes: moduleName).
				moduleLength := objectMemory lengthOf: moduleName.
				self cCode: '' inSmalltalk:
					[ (#('FloatArrayPlugin' 'Matrix2x3Plugin') includes: (self stringOf: moduleName)) "??"
						ifTrue: [moduleLength := 0  "Cause all of these to fail"]]].
	functionName := objectMemory fetchPointer: 1 ofObject: spec.
	self success: (objectMemory isBytes: functionName).
	functionLength := objectMemory lengthOf: functionName.
	self successful ifFalse: [^self primitiveFailFor: -3]. "invalid methodArg state"

	addr := self ioLoadExternalFunction: functionName + objectMemory baseHeaderSize
				OfLength: functionLength
				FromModule: moduleName + objectMemory baseHeaderSize
				OfLength: moduleLength.
	addr = 0 ifTrue:
		[^self primitiveFailFor: -1]. "could not find function; answer generic failure (see below)"

	"Cannot fail this primitive from now on.  Can only fail the external primitive."
	tempOop := objectMemory
						eeInstantiateClassIndex: ClassArrayCompactIndex
						format: objectMemory arrayFormat
						numSlots: (objectMemory hasSpurMemoryManagerAPI
									ifTrue: [5]
									ifFalse: [4]).
	objectMemory
		storePointerUnchecked: 0 ofObject: tempOop withValue: (argumentArray := self popStack);
		storePointerUnchecked: 1 ofObject: tempOop withValue: (primRcvr := self popStack);
		storePointerUnchecked: 2 ofObject: tempOop withValue: self popStack; "the method"
		storePointerUnchecked: 3 ofObject: tempOop withValue: self popStack. "the context receiver"
	self push: primRcvr. "replace context receiver with actual receiver"
	argumentCount := arraySize.
	1 to: arraySize do:
		[:index| self push: (objectMemory fetchPointer: index - 1 ofObject: argumentArray)].
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[objectMemory storePointerUnchecked: 4 ofObject: tempOop withValue: newMethod.
			 newMethod := methodArg.
			 self callExternalPrimitive: addr. "On Spur, sets primitiveFunctionPointer"
			 self maybeRetryPrimitiveOnFailure.
			 newMethod := objectMemory fetchPointer: 4 ofObject: tempOop]
		ifFalse:
			[self callExternalPrimitive: addr].
	self successful ifFalse: "If primitive failed, then restore state for failure code"
		[self pop: arraySize + 1.
		 self push: (objectMemory fetchPointer: 3 ofObject: tempOop).
		 self push: (objectMemory fetchPointer: 2 ofObject: tempOop).
		 self push: (objectMemory fetchPointer: 1 ofObject: tempOop).
		 self push: (objectMemory fetchPointer: 0 ofObject: tempOop).
		 argumentCount := 3.
		 "Must reset primitiveFunctionPointer for checkForAndFollowForwardedPrimitiveState"
		 objectMemory hasSpurMemoryManagerAPI ifTrue:
			[primitiveFunctionPointer := #primitiveDoNamedPrimitiveWithArgs].
		 "Hack.  A nil prim error code (primErrorCode = 1) is interpreted by the image
		  as meaning this primitive is not implemented.  So to pass back nil as an error
		  code we use -1 to indicate generic failure."
		 primFailCode = 1 ifTrue:
			[primFailCode := -1]]