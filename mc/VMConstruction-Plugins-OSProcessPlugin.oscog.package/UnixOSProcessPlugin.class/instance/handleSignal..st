private - signal handers
handleSignal: sigNum 
	"This is a signal handler function which runs when a signal is received
	from the operating system. When the signal is received, a Smalltalk Semaphore
	is signaled. This effectively passes the external signal to Squeak to allow
	it to be handled in Smalltalk."

	| semaIndex |
	<returnTypeC: 'void'>
	<var: 'sigNum' type: 'int'>
	semaIndex := semaIndices at: sigNum.
	self forwardSignal: sigNum toSemaphoreAt: semaIndex. "Reset handler"
	self isVmThread
		ifTrue: [semaIndex > 0
				ifTrue: [interpreterProxy signalSemaphoreWithIndex: semaIndex]]
		ifFalse: [self maskForThisThreadAndResend: sigNum]