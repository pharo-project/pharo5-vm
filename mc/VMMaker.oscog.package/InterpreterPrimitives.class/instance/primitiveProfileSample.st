process primitives
primitiveProfileSample
	"Primitive. Answer the last sample taken by the profiler, or nil if the profiler isn't active.
	See also primitiveProfileStart."
	<export: true>
	self methodArgumentCount = 0 ifFalse:
		[^self primitiveFail].
	self pop: 1 thenPush: profileProcess.
	profileProcess := objectMemory nilObject