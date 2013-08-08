deprecated
setSigPipeIgnore
	"Set the SIGPIPE signal handler in the virtual machine to ignore pipe error signals."

	<returnTypeC: 'void'>
	self setSignalNumber: self sigPipeNumber handler: self sigIgnoreNumber
