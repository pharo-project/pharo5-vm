cog jit support
primTraceLogIndex: aValue
	<cmacro: '(aValue) (GIV(primTraceLogIndex) = (aValue))'>
	"N.B. primTraceLogIndex is 8-bits"
	^primTraceLogIndex := aValue bitAnd: 16rFF