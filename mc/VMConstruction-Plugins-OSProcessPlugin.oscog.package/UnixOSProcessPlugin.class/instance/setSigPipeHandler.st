deprecated
setSigPipeHandler
	"Set the SIGPIPE signal handler in the virtual machine to ignore pipe error signals.
	If a pipe is opened to a child process, and the child exits, then subsequent writes to
	the pipe generate a SIGPIPE signal. If this signal is not handled, the VM will exit
	without warning."

	self setSigPipeIgnore
