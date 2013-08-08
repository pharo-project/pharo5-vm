deprecated
setSigIntIgnore
	"Set the SIGINT signal handler in the virtual machine to ignore interrupts."

	<returnTypeC: 'void'>
	self setSignalNumber: self sigIntNumber handler: self sigIgnoreNumber
