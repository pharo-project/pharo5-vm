private - pthread
maskForThisThreadAndResend: sigNum
	"Prevent any future instances of signal sigNum from being delivered
	to this pthread, and reschedule the current signal to be delivered to
	this OS process. Any pthread other than the interpreter thread will
	call this method. Eventually the signal will be delivered to the
	interpreter thread, which will handle it in the context of the interpreter
	thread."

	<var: 'sigNum' type: 'int'>
	self maskSignalForThisThread: sigNum.
	self resendSignal: sigNum