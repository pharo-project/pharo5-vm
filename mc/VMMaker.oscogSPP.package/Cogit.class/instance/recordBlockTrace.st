debugging
recordBlockTrace
	<api>
	<cmacro: '() (traceFlags & 4)'>
	^(traceFlags bitAnd: 4) ~= 0