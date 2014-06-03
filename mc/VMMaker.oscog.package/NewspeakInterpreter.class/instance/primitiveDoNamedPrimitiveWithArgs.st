plugin primitives
primitiveDoNamedPrimitiveWithArgs
	"Simulate an primitiveExternalCall invocation (e.g. for the Debugger).  Do not cache anything.
	 e.g. ContextPart>>tryNamedPrimitiveIn: aCompiledMethod for: aReceiver withArgs: arguments"
	| argumentArray arraySize index methodArg methodHeader spec
	  moduleName functionName moduleLength functionLength addr |
	<var: #addr declareC: 'void (*addr)()'>

	argumentArray := self stackTop.
	(self isArray: argumentArray) ifFalse:
		[^self primitiveFail]. "invalid args"
	arraySize := self fetchWordLengthOf: argumentArray.
	self success: (self roomToPushNArgs: arraySize).

	methodArg := self stackObjectValue: 2.
	self successful ifFalse:
		[^self primitiveFail]. "invalid args"

	(self isCompiledMethod: methodArg) ifFalse:
		[^self primitiveFail]. "invalid args"

	methodHeader := self headerOf: methodArg.

	(self literalCountOfHeader: methodHeader) > 2 ifFalse:
		[^self primitiveFail]. "invalid methodArg state"
	self assertClassOf: (spec := self fetchPointer: 1 "first literal" ofObject: methodArg)
		is: (self splObj: ClassArray).
	(self successful
	and: [(self lengthOf: spec) = 4
	and: [(self primitiveIndexOfMethodHeader: methodHeader) = 117]]) ifFalse:
		[^self primitiveFail]. "invalid methodArg state"

	(self argumentCountOfMethodHeader: methodHeader) = arraySize ifFalse:
		[^self primitiveFail]. "invalid args (Array args wrong size)"

	"The function has not been loaded yet. Fetch module and function name."
	moduleName := self fetchPointer: 0 ofObject: spec.
	moduleName = nilObj
		ifTrue: [moduleLength := 0]
		ifFalse: [self success: (self isBytes: moduleName).
				moduleLength := self lengthOf: moduleName.
				self cCode: '' inSmalltalk:
					[ (#('FloatArrayPlugin' 'Matrix2x3Plugin') includes: (self stringOf: moduleName)) "??"
						ifTrue: [moduleLength := 0  "Cause all of these to fail"]]].
	functionName := self fetchPointer: 1 ofObject: spec.
	self success: (self isBytes: functionName).
	functionLength := self lengthOf: functionName.
	self successful ifFalse: [^self primitiveFail]. "invalid methodArg state"

	addr := self ioLoadExternalFunction: functionName + BaseHeaderSize
				OfLength: functionLength
				FromModule: moduleName + BaseHeaderSize
				OfLength: moduleLength.
	addr = 0 ifTrue:
		[^self primitiveFail]. "could not find function"

	"Cannot fail this primitive from now on.  Can only fail the external primitive."
	self pop: 1.
	argumentCount := arraySize.
	index := 1.
	[index <= arraySize] whileTrue:
		[self push: (self fetchPointer: index - 1 ofObject: argumentArray).
		 index := index + 1].

	"Run the primitive (sets primFailCode)"
	self pushRemappableOop: argumentArray. "prim might alloc/gc in callback"
	lkupClass := nilObj.
	self callExternalPrimitive: addr.
	argumentArray := self popRemappableOop.
	self successful ifFalse: "If primitive failed, then restore state for failure code"
		[self pop: arraySize thenPush: argumentArray.
		 argumentCount := 3]