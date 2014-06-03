memory space primitives
primitiveIsRoot
	"Primitive. Answer whether the argument to the primitive is a root for young space"
	| oop |
	<export: true>
	oop := self stackObjectValue: 0.
	successFlag ifTrue:
		[self pop: argumentCount + 1 thenPushBool: (self isYoungRoot: oop)]