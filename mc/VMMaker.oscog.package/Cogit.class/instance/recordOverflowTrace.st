debugging
recordOverflowTrace
	<api>
	<cmacro: '() (traceFlags & 32)'>
	^(traceFlags bitAnd: 32) ~= 0