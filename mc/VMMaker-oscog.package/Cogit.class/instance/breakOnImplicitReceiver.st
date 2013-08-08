debugging
breakOnImplicitReceiver
	<api>
	<cmacro: '() (traceFlags & 64)'>
	^(traceFlags bitAnd: 64) ~= 0