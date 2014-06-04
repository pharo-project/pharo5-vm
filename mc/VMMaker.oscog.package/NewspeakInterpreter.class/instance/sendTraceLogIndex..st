debug support
sendTraceLogIndex: aValue
	<cmacro: '(aValue) (GIV(sendTraceLogIndex) = (aValue))'>
	"N.B. sendTraceLogIndex is 8-bits"
	^sendTraceLogIndex := aValue bitAnd: 16rFF