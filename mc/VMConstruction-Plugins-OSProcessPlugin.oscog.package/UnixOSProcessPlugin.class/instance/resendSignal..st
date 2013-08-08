private - pthread
resendSignal: sigNum
	"Signal sigNum has been caught by a thread other than the pthread in which
	the interpreter is executing. Rather than handling it in this thread, resend
	it to the interpreter thread."

	<var: 'sigNum' type: 'int'>
	self cCode: 'pthread_kill(vmThread, sigNum)'