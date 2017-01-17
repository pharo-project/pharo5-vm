process primitives
primitiveProfilePrimitive
	"Primitive. Answer the last primitive method sampled by the profiler."
	<export: true>
	self methodArgumentCount = 0 ifFalse:[^self success: false].
	self pop: 1.
	self push: profileMethod.