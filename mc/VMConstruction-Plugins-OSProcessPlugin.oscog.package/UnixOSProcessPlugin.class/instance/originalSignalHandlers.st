accessing
originalSignalHandlers
	"An array of signal handler function addresses, one for each signal type. The
	value at each entry is the address of the original signal handler function prior
	to having set a handler."

	<returnTypeC: 'void **'>
	^ originalSigHandlers