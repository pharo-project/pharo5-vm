private - pipes
createPipeForReader: readerIOStreamPtr writer: writerIOStreamPtr
	"Create a pipe and populate the readerIOStream and writerIOStream variables.
	The SIGPIPE handler must have been set before creating the pipe. Answer true for
	success, else false."

	| filedes |
	<var: 'readerIOStreamPtr' type: 'FILEHANDLETYPE *'>
	<var: 'writerIOStreamPtr' type: 'FILEHANDLETYPE *'>
	<var: 'filedes' declareC: 'int filedes[2]'>
	((self pipe: filedes) = -1) "Translates to a pipe() system call"
		ifTrue:
			[^ false]
		ifFalse:
			[self cCode: '*writerIOStreamPtr= (FILE *) fdopen (filedes[1], "a")'.
			self cCode: '*readerIOStreamPtr= (FILE *) fdopen (filedes[0], "r")'.
			^ true]
