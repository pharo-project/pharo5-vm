plugin primitives
functionForPrimitiveExternalCall: methodObj
	"Arrange to call the external primitive directly.  The complication is arranging
	 that the call can be flushed, given that it is embedded in machine code."
	<returnTypeC: 'void (*functionForPrimitiveExternalCall(sqInt methodObj))(void)'>
	| lit index functionPointer |
	<var: #functionPointer declareC: #'void (*functionPointer)(void)'>
	cogit setPostCompileHook: #recordCallOffsetIn:.
	(objectMemory literalCountOf: methodObj) > 0 ifFalse:
		[^#primitiveExternalCall].
	lit := self literal: 0 ofMethod: methodObj. 
	"Check if it's an array of length 4"
	((objectMemory isArray: lit) and: [(objectMemory lengthOf: lit) = 4]) ifFalse:
		[^#primitiveExternalCall].
	index := objectMemory fetchPointer: 3 ofObject: lit.
	((objectMemory isIntegerObject: index)
	and: [(index := objectMemory integerValueOf: index) > 0
	and: [index <= MaxExternalPrimitiveTableSize]]) ifFalse:
		[^#primitiveExternalCall].
	functionPointer := externalPrimitiveTable at: index - 1.
	functionPointer = 0 ifTrue:
		[^#primitiveExternalCall].
	^functionPointer