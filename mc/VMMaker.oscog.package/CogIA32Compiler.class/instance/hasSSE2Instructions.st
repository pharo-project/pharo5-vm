testing
hasSSE2Instructions
	"Answer if we support SSE2"
	^(cogit ceCheckFeatures bitAnd: (1 << 26)) ~= 0