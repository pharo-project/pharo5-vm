process primitives
primitiveProfilePrimitive
	"Primitive. Answer the last primitive method sampled by the profiler."
	<export: true>
	self methodArgumentCount = 0 ifFalse:
		[^self primitiveFail].
	self pop: 1 thenPush: profileMethod.
	profileMethod := objectMemory nilObject