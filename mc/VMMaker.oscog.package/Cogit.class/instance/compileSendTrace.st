debugging
compileSendTrace
	<api>
	<cmacro: '() (traceFlags & 2)'>
	"256 = count sends, which is simulation only"
	^(traceFlags bitAnd: 256 + 2) ~= 0