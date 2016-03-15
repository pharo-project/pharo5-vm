source files
extraSources
	" mac VM using some unix sources"
	
	^ 
	'${platformsDir}/unix/plugins/SocketPlugin/sqUnixSocket.c 
	${platformsDir}/unix/vm/aio.c 
	${platformsDir}/unix/plugins/AsynchFilePlugin/sqUnixAsynchFile.c
	${platformsDir}/unix/vm/sqUnixITimerHeartbeat.c
	${platformsDir}/unix/vm/sqUnixVMProfile.c
	${platformsDir}/unix/vm/sqUnixThreads.c
	${resources}'