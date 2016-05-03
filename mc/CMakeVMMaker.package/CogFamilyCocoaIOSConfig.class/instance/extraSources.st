source files
extraSources
	" mac VM using some unix sources "
	
	^super extraSources,'
	${platformsDir}/unix/vm/aio.c 
	${platformsDir}/unix/vm/sqUnixITimerHeartbeat.c 
	${platformsDir}/unix/vm/sqUnixVMProfile.c 
	${platformsDir}/unix/vm/sqUnixThreads.c 
	${platformsDir}/unix/vm/sqUnixSpurMemory.c '