debugging
recordSendTrace
	<api>
	<cmacro: '() (traceFlags & 2)'>
	^(traceFlags bitAnd: 2) ~= 0