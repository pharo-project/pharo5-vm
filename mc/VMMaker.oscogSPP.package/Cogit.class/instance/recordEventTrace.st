debugging
recordEventTrace
	<api>
	<cmacro: '() (traceFlags & 16)'>
	^(traceFlags bitAnd: 16) ~= 0