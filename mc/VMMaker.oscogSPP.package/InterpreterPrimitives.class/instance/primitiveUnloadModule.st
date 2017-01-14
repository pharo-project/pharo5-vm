plugin primitives
primitiveUnloadModule
	"Primitive. Unload the module with the given name."
	"Reloading of the module will happen *later* automatically, when a 
	function from it is called. This is ensured by invalidating current sessionID."
	| moduleName |
	self methodArgumentCount = 1 ifFalse:[^self primitiveFail].
	moduleName := self stackTop.
	(objectMemory isIntegerObject: moduleName) ifTrue:[^self primitiveFail].
	(objectMemory isBytes: moduleName) ifFalse:[^self primitiveFail].
	(self ioUnloadModule: (self oopForPointer: (objectMemory firstIndexableField: moduleName))
		OfLength: (objectMemory byteSizeOf: moduleName)) ifFalse:[^self primitiveFail].
	self flushExternalPrimitives.
	self forceInterruptCheck.
	self pop: 1 "pop moduleName; return receiver"