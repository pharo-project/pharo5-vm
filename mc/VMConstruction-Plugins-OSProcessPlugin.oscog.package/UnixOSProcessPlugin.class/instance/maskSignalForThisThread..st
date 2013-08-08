private - pthread
maskSignalForThisThread: sigNum
	"Prevent future invocations of signal sigNum from being delivered to this pthread."

	| sigset |
	<var: 'sigNum' type: 'int'>
	<var: 'sigset' type: 'sigset_t'>
	self cCode: 'sigemptyset(&sigset)'.
	self cCode: 'sigaddset(&sigset, sigNum)'.
	self cCode: 'pthread_sigmask(SIG_BLOCK, &sigset, NULL)'
