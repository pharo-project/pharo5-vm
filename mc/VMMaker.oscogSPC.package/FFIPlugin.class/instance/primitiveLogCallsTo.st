primitives
primitiveLogCallsTo
	"Enable logging of FFI calls by providing it with a log file name."
	| logFile ok |
	<export: true>
	interpreterProxy methodArgumentCount = 1 
		ifFalse:[^interpreterProxy primitiveFail].
	logFile := interpreterProxy stackObjectValue: 0.
	logFile == interpreterProxy nilObject ifTrue:[ "disable logging"
		ok := self ffiLogFileName: nil OfLength: 0.
		ok ifFalse:[^interpreterProxy primitiveFail].
		ffiLogEnabled := false.
	] ifFalse:[ "enable logging"
		(interpreterProxy isBytes: logFile) ifFalse:[^interpreterProxy primitiveFail].
		ok := self ffiLogFileName: (interpreterProxy firstIndexableField: logFile)
					OfLength: (interpreterProxy byteSizeOf: logFile).
		ok ifFalse:[^interpreterProxy primitiveFail].
		ffiLogEnabled := true.
	].
	^interpreterProxy pop: 1. "pop arg; return rcvr"
