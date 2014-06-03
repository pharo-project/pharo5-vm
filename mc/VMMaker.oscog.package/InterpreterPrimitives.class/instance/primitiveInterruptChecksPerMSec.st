process primitives
primitiveInterruptChecksPerMSec
	"Primitive. Answer the number of interrupt checks per milliseconds that we execute
	on this machine. This can be used to adjust the sub-msecs profiler to check (roughly) 
	n times per millisecond."
	<export: true>
	self methodArgumentCount = 0 ifFalse:[^self success: false].
	self pop: 1 thenPush: (objectMemory integerObjectOf: self ioHeartbeatMilliseconds).