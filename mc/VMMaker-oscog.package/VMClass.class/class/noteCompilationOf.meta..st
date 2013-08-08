translation
noteCompilationOf: aSelector meta: isMeta
	"note the recompiliation by resetting the timeStamp "
	timeStamp := Time totalSeconds.
	^super noteCompilationOf: aSelector meta: isMeta