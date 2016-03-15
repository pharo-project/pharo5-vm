as yet unclassified
platformSources
	"answer the same set of source files except that sqUnixMain.c is replaced with sqUnixEvtMain.c,
	sqUnixHeartbeat.c is replaced with sqUnixEvtBeat.c"

  ^ super platformSources collect: [ :file | (file = 'sqUnixMain.c') 
											ifTrue: 'sqUnixEvtMain.c'  
											ifFalse: [(file = 'sqUnixITimerHeartbeat.c') 
												ifTrue: 'sqUnixEvtBeat.c'
												ifFalse: file]
											].

