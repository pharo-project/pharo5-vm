debugging
compileSendTrace
	"2 is trace sends; 256+2 is traceLinkedSends, so one can trace just unlinked sends using 2"
	<cmacro: '() ((traceFlags & 258) == 258)'>
	^traceFlags allMask: 256 + 2