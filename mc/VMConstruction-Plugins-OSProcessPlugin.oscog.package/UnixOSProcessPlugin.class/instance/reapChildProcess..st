deprecated
reapChildProcess: sigNum
	"This is a signal handler for SIGCHLD. It is not meant to be called from Smalltalk,
	and should only be called indirectly as a result of a death of child signal from
	the operating system.

	Child processes must be cleaned up by the parent, otherwise they continue
	to exist as zombies until the parent exits. This handler resets the signal handler
	to catch the next SIGCHLD signal, then sets a semaphore to notify the system
	that a child process needs to be cleaned up. The actual clean up is done by a
	Smalltalk process which waits on the semaphore, then calls primitiveReapChildProcess.

	Note: If child processes die faster than we can clean them up, signals will be lost
	and child processes will remain as zombies."

	<returnTypeC: 'void'>
	<var: 'sigNum' type: 'int'>
	self cPreprocessorDirective: '#if !defined(SA_NOCLDSTOP)'.
	self setSigChldHandler.	"Reset handler; not needed if using sigaction and not specifying SA_RESETHAND"
	self cPreprocessorDirective: '#endif /* defined(SA_NOCLDSTOP) */'.
	(sigChldSemaIndex > 0) ifTrue:
		[interpreterProxy signalSemaphoreWithIndex: sigChldSemaIndex]
