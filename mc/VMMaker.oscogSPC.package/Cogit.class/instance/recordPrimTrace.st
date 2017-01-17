debugging
recordPrimTrace
	<api>
	<cmacro: '() (traceFlags & 8)'>
	^(traceFlags bitAnd: 8) ~= 0