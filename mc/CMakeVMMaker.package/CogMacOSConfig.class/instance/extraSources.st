source files
extraSources
	" mac VM using some unix sources"
	
	^ 
	'${platformsDir}/unix/plugins/SocketPlugin/sqUnixSocket.c 
	${platformsDir}/unix/vm/aio.c 
	${platformsDir}/unix/plugins/AsynchFilePlugin/sqUnixAsynchFile.c
	${platformsDir}/unix/vm/sqUnixHeartbeat.c
	${platformsDir}/unix/vm/sqUnixVMProfile.c
	${platformsDir}/unix/vm/sqUnixThreads.c
	${resources}'