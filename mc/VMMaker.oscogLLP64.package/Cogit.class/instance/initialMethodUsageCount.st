generate machine code
initialMethodUsageCount
	"Answer a usage count that reflects likely long-term usage.
	 Answer 1 for non-primitives or quick primitives (inst var accessors),
	 2 for methods with interpreter primitives, and 3 for compiled primitives."
	(primitiveIndex = 1
	 or: [coInterpreter isQuickPrimitiveIndex: primitiveIndex]) ifTrue:
		[^1].
	self primitiveGeneratorOrNil ifNil:
		[^2].
	^3