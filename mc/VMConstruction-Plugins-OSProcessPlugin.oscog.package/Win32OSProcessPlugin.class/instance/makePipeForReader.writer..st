deprecated
makePipeForReader: readerIOStreamPtr writer: writerIOStreamPtr
	"Create a pipe and populate the readerIOStream and writerIOStream variables.
	Answer true for success, else false"

	<var: 'readerIOStreamPtr' type: 'FILEHANDLETYPE *'>
	<var: 'writerIOStreamPtr' type: 'FILEHANDLETYPE *'>
	^ self cCode: 'CreatePipe(readerIOStreamPtr, writerIOStreamPtr, NULL, 0)'
