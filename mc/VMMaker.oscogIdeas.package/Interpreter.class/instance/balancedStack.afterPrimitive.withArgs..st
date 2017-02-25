debug support
balancedStack: delta afterPrimitive: primIdx withArgs: nArgs
	"Return true if the stack is still balanced after executing primitive primIndex with nArgs args. Delta is 'stackPointer - activeContext' which is a relative measure for the stack pointer (so we don't have to relocate it during the primitive)"
	(primIdx >= 81 and:[primIdx <= 88]) ifTrue:[^true].
	"81-88 are control primitives after which the stack may look unbalanced"
	successFlag ifTrue:[
		"Successful prim, stack must have exactly nArgs arguments popped off"
		^(stackPointer - activeContext + (nArgs * self wordSize)) = delta
	].
	"Failed prim must leave stack intact"
	^(stackPointer - activeContext) = delta
