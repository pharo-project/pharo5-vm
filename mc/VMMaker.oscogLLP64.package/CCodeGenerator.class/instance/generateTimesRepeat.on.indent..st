C translation
generateTimesRepeat: msgNode on: aStream indent: level
	"Generate while(1) { stmtList } "

	msgNode receiver value timesRepeat:
		[msgNode args first emitCCodeOn: aStream level: level generator: self]