testing
hasDoublePrecisionFloatingPointSupport
	"We can generate dpfp support if the processor has SSE2 instructions."
	<inline: true>
	^self hasSSE2Instructions