source files
extraSources
	" mac VM using some unix sources "
	
	^super extraSources,'
	${platformsDir}/unix/vm/aio.c 
	${platformsDir}/unix/vm/sqUnixHeartbeat.c 
	${platformsDir}/unix/vm/sqUnixVMProfile.c 
	${platformsDir}/unix/vm/sqUnixThreads.c '