plugin primitives
primitiveDoNamedPrimitiveWithArgs
	"Simulate an primitiveExternalCall invocation (e.g. for the Debugger).  Do not cache anything.
	 e.g. ContextPart>>tryNamedPrimitiveIn: aCompiledMethod for: aReceiver withArgs: arguments"
	| argumentArray arraySize methodArg methodHeader
	  moduleName functionName moduleLength functionLength
	  spec addr primRcvr ctxtRcvr isArray |
	<var: #addr declareC: 'void (*addr)()'>
	argumentArray := self stackTop.
	methodArg := self stackValue: 2.
	((objectMemory isArray: argumentArray)
	 and: [objectMemory isOopCompiledMethod: methodArg]) ifFalse:
		[^self primitiveFailFor: -2]. "invalid args"
	arraySize := objectMemory fetchWordLengthOf: argumentArray.
	(self roomToPushNArgs: arraySize) ifFalse:
		[^self primitiveFailFor: -2]. "invalid args"

	methodHeader := self headerOf: methodArg.
	(self literalCountOfHeader: methodHeader) > 2 ifFalse:
		[^self primitiveFailFor: -3]. "invalid methodArg state"
	spec := objectMemory fetchPointer: 1 "first literal" ofObject: methodArg.
	isArray := self isInstanceOfClassArray: spec.
	(isArray
	and: [(objectMemory lengthOf: spec) = 4
	and: [(self primitiveIndexOfMethod: methodArg header: methodHeader) = 117]]) ifFalse:
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

	addr := self ioLoadExternalFunction: functionName + BaseHeaderSize
				OfLength: functionLength
				FromModule: moduleName + BaseHeaderSize
				OfLength: moduleLength.
	addr = 0 ifTrue:
		[^self primitiveFailFor: -1]. "could not find function; answer generic failure (see below)"

	"Cannot fail this primitive from now on.  Can only fail the external primitive."
	objectMemory pushRemappableOop: (argumentArray := self popStack).
	objectMemory pushRemappableOop: (primRcvr := self popStack).
	objectMemory pushRemappableOop: self popStack. "the method"
	objectMemory pushRemappableOop: self popStack. "the context receiver"
	self push: primRcvr. "replace context receiver with actual receiver"
	argumentCount := arraySize.
	1 to: arraySize do:
		[:index| self push: (objectMemory fetchPointer: index - 1 ofObject: argumentArray)].
	self callExternalPrimitive: addr.
	ctxtRcvr  := objectMemory popRemappableOop.
	methodArg := objectMemory popRemappableOop.
	primRcvr := objectMemory popRemappableOop.
	argumentArray := objectMemory popRemappableOop.
	self successful ifFalse: "If primitive failed, then restore state for failure code"
		[self pop: arraySize + 1.
		 self push: ctxtRcvr.
		 self push: methodArg.
		 self push: primRcvr.
		 self push: argumentArray.
		 argumentCount := 3.
		 "Hack.  A nil prim error code (primErrorCode = 1) is interpreted by the image
		  as meaning this primitive is not implemented.  So to pass back nil as an error
		  code we use -1 to indicate generic failure."
		 primFailCode = 1 ifTrue:
			[primFailCode := -1]]