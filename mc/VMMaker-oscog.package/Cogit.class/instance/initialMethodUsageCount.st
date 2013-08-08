generate machine code
initialMethodUsageCount
	"Answer a usage count that reflects likely long-term usage.
	 Answer 0 for non-primitives or quick primitives (inst var accessors),
	 1 for methods with interpreter primitives, and 2 for compiled primitives."
	(primitiveIndex = 0
	 or: [coInterpreter isQuickPrimitiveIndex: primitiveIndex]) ifTrue:
		[^0].
	self primitiveGeneratorOrNil isNil ifTrue:
		[^1].
	^2