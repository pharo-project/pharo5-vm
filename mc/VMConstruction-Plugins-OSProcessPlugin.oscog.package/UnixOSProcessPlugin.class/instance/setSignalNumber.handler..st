private - signal handers
setSignalNumber: anInteger handler: signalHandlerAddress
	"Set a signal handler. The C code translator will convert #sig:nal: into 'signal(parm1, parm2)'"

	| oldHandlerAddress |
	<returnTypeC: 'void *'>
	<var: 'signalHandlerAddress' type: 'void *'>
	^ self sig: anInteger nal: signalHandlerAddress
