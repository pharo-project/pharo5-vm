debugging
printOnTrace
	<api>
	<cmacro: '() (traceFlags & 1)'>
	^(traceFlags bitAnd: 1) ~= 0