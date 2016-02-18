private - signal handers
setSignalNumber: signalNumber handler: signalHandlerAddress
	"Set a signal handler. The C code translator will convert #sig:nal: into 'signal(parm1, parm2)'"

	| sigHandlerAction oldHandlerAction |
	<returnTypeC: 'void *'>
	<var: 'signalHandlerAddress' type: 'void *'>
	<var: 'sigHandlerAction' declareC: #'struct sigaction sigHandlerAction = {{0}}'>
	<var: 'oldHandlerAction' declareC: #'struct sigaction oldHandlerAction = {{0}}'>
	self needSigaltstack ifFalse:
		[^self sig: signalNumber nal: signalHandlerAddress].

	self cCode: 'sigHandlerAction.sa_sigaction = signalHandlerAddress'.
	self cCode: 'sigHandlerAction.sa_flags = SA_ONSTACK | SA_RESTART'.
	self cCode: 'sigemptyset(&sigHandlerAction.sa_mask)'.
	((self sig: signalNumber act: (self addressOf: sigHandlerAction) ion: (self addressOf: oldHandlerAction)) = self sigErrorNumber) ifTrue:
		[self perror: 'signal'].
	^self cCode: 'oldHandlerAction.sa_sigaction'