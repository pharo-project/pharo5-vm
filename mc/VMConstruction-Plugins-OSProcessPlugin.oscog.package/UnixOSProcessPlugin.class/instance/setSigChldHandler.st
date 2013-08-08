deprecated
setSigChldHandler
	"Set the SIGCHLD signal handler in the virtual machine."

	<returnTypeC: 'void'>
	| sigchldHanderAction |
	<var: 'sigchldHanderAction' type: 'struct sigaction'>
	self cPreprocessorDirective: '#if defined(SA_NOCLDSTOP)'.
	self cCode: 'sigchldHanderAction.sa_sigaction = reapChildProcess'.
	self cCode: 'sigchldHanderAction.sa_flags = SA_NODEFER | SA_NOCLDSTOP'.
	self cCode: 'sigemptyset(&sigchldHanderAction.sa_mask)'.
	((self cCode: 'sigaction(SIGCHLD, &sigchldHanderAction, 0)' inSmalltalk: [self sigErrorNumber]) == self sigErrorNumber)
		ifTrue: [self perror: 'signal'].
	self cPreprocessorDirective: '#else /* defined(SA_NOCLDSTOP) */'.
	((self cCode: 'signal(SIGCHLD, reapChildProcess)' inSmalltalk: [self sigErrorNumber]) == self sigErrorNumber)
		ifTrue: [self perror: 'signal'].
	self cPreprocessorDirective: '#endif /* defined(SA_NOCLDSTOP) */'