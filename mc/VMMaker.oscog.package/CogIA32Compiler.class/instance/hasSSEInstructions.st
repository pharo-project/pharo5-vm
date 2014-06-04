testing
hasSSEInstructions
	"Answer if we support SSE"
	^(cogit ceCheckFeatures bitAnd: (1 << 25)) ~= 0